import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/models/app_settings.dart';
import '../../../shared/theme/app_colors.dart';

class SecurityScreen extends ConsumerWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Security & Privacy'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (settings) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionHeader('APP ACCESS'),
              _buildToggleTile(
                context,
                ref,
                title: 'Biometric Lock',
                subtitle: 'Require Fingerprint or FaceID to open app',
                value: settings.biometricEnabled,
                icon: Icons.fingerprint_rounded,
                onChanged: (val) async {
                  if (val) {
                    // Verify biometric before enabling
                    final auth = LocalAuthentication();
                    final canAuth = await auth.canCheckBiometrics || await auth.isDeviceSupported();
                    if (!canAuth) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Biometrics not available on this device')),
                        );
                      }
                      return;
                    }
                    
                    final authenticated = await auth.authenticate(
                      localizedReason: 'Confirm identity to enable lock',
                      options: const AuthenticationOptions(stickyAuth: true),
                    );
                    
                    if (!authenticated) return;
                  }
                  
                  final service = await ref.read(appSettingsServiceProvider.future);
                  await service.setBiometric(val);
                },
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('PRIVACY'),
              _buildToggleTile(
                context,
                ref,
                title: 'Privacy Mode',
                subtitle: 'Mask all balances and amounts across the app',
                value: settings.privacyModeEnabled,
                icon: Icons.visibility_off_outlined,
                onChanged: (val) async {
                  final service = await ref.read(appSettingsServiceProvider.future);
                  await service.setPrivacyMode(val);
                },
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, color: AppColors.textTertiary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'PaisaPlus uses native hardware encryption (Secure Enclave / Keystore) for your local data.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: AppColors.textTertiary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleTile(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }
}
