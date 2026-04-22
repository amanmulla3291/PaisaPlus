// lib/features/auth/device_mismatch_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// Shown when device fingerprint doesn't match the stored one.
// Enforces the 1-device policy.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/auth_service.dart';
import '../../shared/theme/app_colors.dart';

class DeviceMismatchScreen extends ConsumerWidget {
  const DeviceMismatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(flex: 2),

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(28),
                  border:
                      Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: const Center(
                  child: Text('📵', style: TextStyle(fontSize: 48)),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Different Device Detected',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              const Text(
                'Your account is bound to a different device.\n\nTo use PaisaPlus on this device, restore your encrypted backup (.enc file) here first.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),

              const Spacer(flex: 3),

              // Restore backup (Phase 5)
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Backup restore coming in Phase 5 🔐'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Restore Backup',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () =>
                    ref.read(authProvider.notifier).signOut(),
                child: const Text(
                  'Sign out',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}