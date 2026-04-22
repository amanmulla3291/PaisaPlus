// lib/features/auth/pending_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// Shown to normal users who have signed in but haven't been approved yet.
// Polls for approval status. Sign-out option available.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/auth_service.dart';
import '../../shared/theme/app_colors.dart';

class PendingScreen extends ConsumerStatefulWidget {
  const PendingScreen({super.key});

  @override
  ConsumerState<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends ConsumerState<PendingScreen> {
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    // Poll every 30 seconds for admin approval
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      ref.read(authProvider.notifier).refreshProfile();
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final name = authState.profile?.fullName?.split(' ').first ?? 'there';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // ── Illustration ────────────────────────────────────────────
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Center(
                  child: Text('⏳', style: TextStyle(fontSize: 48)),
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'Hey $name! 👋',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Your account is pending approval.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              const Text(
                'An admin will review and approve your account shortly. This usually takes just a few minutes.\n\nYou\'ll be automatically redirected once approved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 32),

              // ── Animated waiting indicator ──────────────────────────────
              const _PulsingDots(),

              const Spacer(flex: 3),

              // ── Refresh manually ────────────────────────────────────────
              OutlinedButton(
                onPressed: () =>
                    ref.read(authProvider.notifier).refreshProfile(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.border),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Check approval status',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ── Sign out ─────────────────────────────────────────────────
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

// ── Animated pulsing dots indicator ──────────────────────────────────────────
class _PulsingDots extends StatefulWidget {
  const _PulsingDots();

  @override
  State<_PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<_PulsingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (idx) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final delay = idx * 0.2;
            final value = ((_controller.value - delay) % 1.0).clamp(0.0, 1.0);
            final scale = 0.6 + 0.4 * (1 - (2 * value - 1).abs());
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}