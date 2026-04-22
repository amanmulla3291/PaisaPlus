// lib/core/supabase/supabase_client.dart
// ─────────────────────────────────────────────────────────────────────────────
// Supabase client provider + UserProfile model.
// The UserProfile only contains auth metadata — NO financial data ever.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ── Supabase client singleton ─────────────────────────────────────────────────
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// ── Current Supabase auth user (null when logged out) ────────────────────────
final supabaseAuthUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});

// ── UserProfile: only auth metadata — stored in Supabase profiles table ──────
class UserProfile {
  final String id;           // = auth.users.id (UUID)
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final bool isAdmin;
  final bool approved;
  final String? deviceFingerprint; // SHA-256 hash only

  const UserProfile({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    required this.isAdmin,
    required this.approved,
    this.deviceFingerprint,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['full_name'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      isAdmin: map['is_admin'] as bool? ?? false,
      approved: map['approved'] as bool? ?? false,
      deviceFingerprint: map['device_fingerprint'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'avatar_url': avatarUrl,
        'is_admin': isAdmin,
        'approved': approved,
        'device_fingerprint': deviceFingerprint,
      };

  UserProfile copyWith({
    String? fullName,
    String? avatarUrl,
    bool? isAdmin,
    bool? approved,
    String? deviceFingerprint,
  }) {
    return UserProfile(
      id: id,
      email: email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isAdmin: isAdmin ?? this.isAdmin,
      approved: approved ?? this.approved,
      deviceFingerprint: deviceFingerprint ?? this.deviceFingerprint,
    );
  }
}

// ── UserProfile async provider — fetches from Supabase profiles table ─────────
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final client = ref.watch(supabaseClientProvider);
  final user = client.auth.currentUser;
  if (user == null) return null;

  final response = await client
      .from('profiles')
      .select()
      .eq('id', user.id)
      .single();

  return UserProfile.fromMap(response);
});