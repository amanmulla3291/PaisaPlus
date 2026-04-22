// lib/app.dart
// ─────────────────────────────────────────────────────────────────────────────
// PaisaPlusApp — root widget.
// Wires up GoRouter (auth-gated) + Kite dark theme.
//
// FIX — P0 UI/Navigation Lag:
//   Changed `ref.watch(appRouterProvider)` → `ref.read(appRouterProvider)`.
//
//   The original `ref.watch` caused PaisaPlusApp.build() to re-run every time
//   appRouterProvider emitted a new value. Even though appRouterProvider is now
//   fixed to never recreate the router, using `ref.watch` here would still
//   subscribe PaisaPlusApp to the provider and trigger unnecessary rebuilds.
//   `ref.read` retrieves the router once at first build — correct for a
//   singleton that never changes.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared/router/app_router.dart';
import 'shared/theme/app_theme.dart';
import 'features/security/widgets/app_lock_wrapper.dart';

class PaisaPlusApp extends ConsumerWidget {
  const PaisaPlusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read — the router is a singleton; no rebuild needed when auth changes.
    // Auth-driven navigation is handled internally by GoRouter's refreshListenable.
    final router = ref.read(appRouterProvider);

    return MaterialApp.router(
      title: 'PaisaPlus',
      debugShowCheckedModeBanner: false,

      // ── Kite-level dark theme (Zerodha red accents) ─────────────────────
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // ── GoRouter integration ────────────────────────────────────────────
      routerConfig: router,
      builder: (context, child) {
        return AppLockWrapper(child: child!);
      },
    );
  }
}