// lib/features/more/backup_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// UI for handling encrypted backups and cloud metadata sync.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import '../../shared/theme/app_colors.dart';
import '../../core/isar/providers/service_providers.dart';
import '../../core/services/auth_service.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _isExporting = false;
  bool _isImporting = false;

  Future<void> _handleExport() async {
    setState(() => _isExporting = true);
    try {
      final service = await ref.read(backupServiceProvider.future);
      await service.exportBackup();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Backup exported successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  Future<void> _handleImport() async {
    // 1. Ask for confirmation
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Restore Data?', style: TextStyle(color: AppColors.textPrimary)),
        content: const Text(
          'This will overwrite ALL current local data with the backup. This action cannot be undone.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Confirm Restore'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // 2. Pick file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['paisaplus', 'enc'],
    );

    if (result == null || result.files.single.path == null) return;

    setState(() => _isImporting = true);
    try {
      final service = await ref.read(backupServiceProvider.future);
      await service.restoreBackup(File(result.files.single.path!));
      
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.surface,
            title: const Text('Success', style: TextStyle(color: AppColors.textPrimary)),
            content: const Text('Database restored. Please restart the app to see your data.'),
            actions: [
              TextButton(
                onPressed: () => exit(0), // Simple way to force restart on mobile
                child: const Text('Exit App'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore failed: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(authProvider).profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Backup & Sync',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Metadata Sync Info ──────────────────────────────────────────
          _buildInfoCard(
            icon: Icons.sync_rounded,
            color: Colors.blue,
            title: 'Metadata Cloud Sync',
            description: 'Syncs category icons, account names, and app settings. No financial amounts or transaction notes leave your device.',
          ),
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.person_rounded, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.fullName ?? 'Not Logged In',
                            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                          Text(
                            profile?.email ?? 'Sync is disabled',
                            style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                          ),
                        ],
                      ),
                    ),
                    if (profile == null)
                      TextButton(
                        onPressed: () => ref.read(authProvider.notifier).signInWithGoogle(),
                        child: const Text('Login'),
                      ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Encrypted Backups ───────────────────────────────────────────
          const Text(
            'PRIVATE ENCRYPTED BACKUPS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.textTertiary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          _MenuButton(
            icon: Icons.share_rounded,
            title: 'Export to Cloud',
            subtitle: 'Share encrypted backup to Drive/Email',
            onTap: _isExporting ? null : _handleExport,
            trailing: _isExporting ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : null,
          ),
          const SizedBox(height: 12),
          _MenuButton(
            icon: Icons.file_open_rounded,
            title: 'Restore from File',
            subtitle: 'Import a .paisaplus backup file',
            onTap: _isImporting ? null : _handleImport,
            trailing: _isImporting ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : null,
          ),

          const SizedBox(height: 32),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_outline_rounded, color: AppColors.error, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Backups are encrypted with your device-specific master key. They can only be restored on this device or with your account recovery key.',
                    style: TextStyle(fontSize: 12, color: AppColors.error, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required Color color, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _MenuButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                color: AppColors.textTertiary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.textSecondary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                ],
              ),
            ),
            trailing ?? const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
