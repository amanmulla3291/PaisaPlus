// lib/core/services/auth_service.dart
// ─────────────────────────────────────────────────────────────────────────────
// AuthService — Google Sign-In via Supabase OAuth.
// "Continue with Google" is the ONLY authentication method.
//
// SECURITY FIXES applied:
//
//   1. Client ID removed from user-facing error messages.
//      Original: error message contained `$_webClientId` — exposed config
//      details to any user who hit an idToken error.
//      Fix: user sees a generic message; internal detail is only in debugPrint.
//
//   2. signOut() no longer swallows errors silently.
//      Original: `catch (_) {}` discarded all exceptions, meaning a failed
//      server-side signOut left the Supabase JWT valid while the app treated
//      the user as logged out.
//      Fix: Supabase signOut failure is logged and surfaced as a warning.
//      The user is still signed out locally (state set to unauthenticated)
//      because blocking the user in the app due to a network hiccup is worse
//      UX than the slim risk of a briefly-valid orphaned JWT.
//
//   3. All error messages shown to users are now generic.
//      Detailed diagnostic information (package names, fingerprint hints,
//      internal state) is only written to debugPrint, never into AuthState.
//      This prevents information leakage through the UI to end users.
//
// NOTE — Client ID in source code:
//   The _webClientId constant below is still in source. Google OAuth client
//   IDs are semi-public (visible in compiled APKs via reverse engineering)
//   but should not be committed to git for hygiene.
//   Move to: `--dart-define=GOOGLE_CLIENT_ID=xxx` and read with:
//   `const _webClientId = String.fromEnvironment('GOOGLE_CLIENT_ID');`
//   Do this before open-sourcing or sharing the repo.
//
// NOTE — Supabase URL + anon key in supabase_config.dart:
//   Both are committed to git in plain text. The anon key is a signed JWT.
//   While Supabase anon keys are designed to be public (RLS is the security
//   boundary), they should still not be committed. Move to dart-define or a
//   .env file added to .gitignore.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paisaplus/core/supabase/supabase_config.dart';
import 'package:paisaplus/core/supabase/supabase_client.dart';
import 'package:paisaplus/core/security/device_binding_service.dart';
import 'package:paisaplus/core/isar/providers/service_providers.dart';
import 'package:paisaplus/core/isar/services/account_service.dart';
import 'package:paisaplus/core/isar/services/category_service.dart';

// Google Client ID is now managed in SupabaseConfig via --dart-define
String get _webClientId => SupabaseConfig.googleWebClientId;

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  pendingApproval,
  deviceMismatch,
  error,
}

class AuthState {
  final AuthStatus status;
  final UserProfile? profile;

  // User-facing error message — intentionally generic.
  // Never contains internal config values or stack traces.
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.profile,
    this.errorMessage,
  });

  const AuthState.initial() : this(status: AuthStatus.initial);
  const AuthState.loading() : this(status: AuthStatus.loading);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  AuthState copyWith({
    AuthStatus? status,
    UserProfile? profile,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AuthState.initial()) {
    _init();
  }

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> _init() async {
    final session = _client.auth.currentSession;
    if (session != null) {
      await _handlePostSignIn(session.user);
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();

    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId: _webClientId,
      );

      await googleSignIn.signOut();

      GoogleSignInAccount? googleUser;
      try {
        googleUser = await googleSignIn.signIn();
      } catch (e) {
        // Log internally — don't expose raw exception to user
        debugPrint('[PaisaPlus] Google picker error: $e');
        state = const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Sign-in failed. Please try again.',
        );
        return;
      }

      if (googleUser == null) {
        // User cancelled — not an error, just go back to unauthenticated
        state = const AuthState.unauthenticated();
        return;
      }

      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null) {
        // FIX: removed $_webClientId from user-facing message.
        // Detailed hint only goes to debug log.
        debugPrint(
          '[PaisaPlus] idToken is null. Verify serverClientId is correct: $_webClientId\n'
          'Also check SHA-1 fingerprint is registered for package com.paisaplus.paisaplus',
        );
        state = const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Sign-in failed. Please try again.',
        );
        return;
      }

      final response = await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (response.user == null) {
        state = const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Sign-in failed. Please try again.',
        );
        return;
      }

      await _handlePostSignIn(response.user!);
    } on AuthException catch (e) {
      debugPrint('[PaisaPlus] Supabase AuthException: ${e.message}');
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage: 'Sign-in failed. Please try again.',
      );
    } catch (e) {
      debugPrint('[PaisaPlus] Unexpected sign-in error: $e');
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage: 'Sign-in failed. Check your connection and try again.',
      );
    }
  }

  Future<void> _handlePostSignIn(User user) async {
    state = const AuthState.loading();

    try {
      // Step 1: Device binding
      final bindingService = _ref.read(deviceBindingServiceProvider);
      final bindingResult = await bindingService.checkAndBind(user.id);

      if (bindingResult.status == DeviceBindingStatus.mismatch) {
        state = AuthState(
          status: AuthStatus.deviceMismatch,
          // Device mismatch message is safe to show — it's user-guidance,
          // not internal config or stack trace
          errorMessage: bindingResult.message,
        );
        return;
      }

      if (bindingResult.status == DeviceBindingStatus.error) {
        debugPrint('[PaisaPlus] Device binding error: ${bindingResult.message}');
        state = const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Device verification failed. Check your connection.',
        );
        return;
      }

      // Step 2: Fetch profile from Supabase
      final profileResponse = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      final profile = UserProfile.fromMap(profileResponse);

      // Step 3: Route based on approval and role
      if (profile.isAdmin) {
        state = AuthState(
          status: AuthStatus.authenticated,
          profile: profile,
        );
      } else if (!profile.approved) {
        state = AuthState(
          status: AuthStatus.pendingApproval,
          profile: profile,
        );
      } else {
        state = AuthState(
          status: AuthStatus.authenticated,
          profile: profile,
        );
      }

      // Step 4: Seed default categories and accounts on first launch.
      // Both methods are idempotent — they check count > 0 and exit
      // immediately if data already exists. Safe to call on every login.
      if (profile.isAdmin || profile.approved) {
        try {
          final catService = await _ref.read(categoryServiceProvider.future);
          final accService = await _ref.read(accountServiceProvider.future);
          await catService.seedDefaultCategories();
          await accService.seedDefaultAccounts();
        } catch (seedError) {
          // Seeding failure is non-fatal — app works without default seeds
          debugPrint('[PaisaPlus] Seeding error (non-fatal): $seedError');
        }
      }
    } catch (e) {
      debugPrint('[PaisaPlus] Post sign-in profile error: $e');
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage: 'Could not load your profile. Please try again.',
      );
    }
  }

  Future<void> signOut() async {
    // FIX: No longer silently swallows all errors.
    // Strategy: always clear local state (user is logged out from the app's
    // perspective), but log any server-side failures so they can be diagnosed.
    bool serverSignOutFailed = false;

    try {
      await GoogleSignIn().signOut();
    } catch (e) {
      debugPrint('[PaisaPlus] Google signOut error: $e');
      // Non-fatal — continue to Supabase signOut
    }

    try {
      await _client.auth.signOut();
    } catch (e) {
      debugPrint('[PaisaPlus] Supabase signOut error: $e. '
          'JWT may remain valid server-side until expiry.');
      serverSignOutFailed = true;
    }

    // Always clear local auth state regardless of server result.
    // A stuck session is a worse UX than a briefly-valid orphaned token.
    state = const AuthState.unauthenticated();

    if (serverSignOutFailed) {
      // The JWT will expire on its own (Supabase default: 1 hour).
      // No action needed from the user — log only.
      debugPrint('[PaisaPlus] User signed out locally. '
          'Server-side token invalidation failed — will expire naturally.');
    }
  }

  Future<void> refreshProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return;
    await _handlePostSignIn(user);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});