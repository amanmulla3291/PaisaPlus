// lib/features/more/more_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// The 'More' screen — central hub for premium features and settings.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/auth_service.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/router/app_router.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(authProvider).profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          
          // ── Profile Card ───────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 28,
                  child: Text(
                    (profile?.fullName?.isNotEmpty == true) ? profile!.fullName![0].toUpperCase() : 'U',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile?.fullName ?? 'PaisaPlus User',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        profile?.email ?? 'private@paisaplus.app',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // ── Premium Features Section ───────────────────────────────────────
          const Text(
            'PREMIUM FEATURES',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          
          _MenuTile(
            icon: Icons.savings_rounded,
            color: AppColors.chartColors[2],
            title: 'Savings Goals',
            subtitle: 'Track progress for your big dreams',
            onTap: () => context.push(AppRoutes.goals),
          ),
          _MenuTile(
            icon: Icons.handshake_rounded,
            color: AppColors.chartColors[1],
            title: 'Loans & Debts',
            subtitle: 'Manage who owes you and vice versa',
            onTap: () => context.push(AppRoutes.loans),
          ),
          _MenuTile(
            icon: Icons.auto_mode_rounded,
            color: AppColors.primary,
            title: 'Automations',
            subtitle: 'Scheduled recurring transactions',
            onTap: () => context.push(AppRoutes.automations),
          ),
          _MenuTile(
            icon: Icons.subscriptions_rounded,
            color: AppColors.chartColors[4],
            title: 'Subscriptions',
            subtitle: 'Control your recurring bills & burn',
            onTap: () => context.push(AppRoutes.subscriptions),
          ),
          _MenuTile(
            icon: Icons.account_balance_rounded,
            color: Colors.teal,
            title: 'Manage Accounts',
            subtitle: 'Configure your banks, wallets and cards',
            onTap: () => context.push(AppRoutes.accounts),
          ),
          
          const SizedBox(height: 32),
          
          // ── App Settings Section ──────────────────────────────────────────
          const Text(
            'APP SETTINGS',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          
          _MenuTile(
            icon: Icons.security_rounded,
            color: Colors.blueGrey,
            title: 'Security & Privacy',
            subtitle: 'Biometrics and global privacy masking',
            onTap: () => context.push(AppRoutes.security),
          ),
          _MenuTile(
            icon: Icons.cloud_upload_rounded,
            color: Colors.blueAccent,
            title: 'Backup & Restore',
            subtitle: 'Encrypted local backups',
            onTap: () => context.push(AppRoutes.backup),
          ),
          
          const SizedBox(height: 48),
          
          // ── Sign Out ───────────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () => ref.read(authProvider.notifier).signOut(),
              icon: const Icon(Icons.logout_rounded, size: 20),
              label: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w700)),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}
