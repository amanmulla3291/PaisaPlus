// lib/features/recurring/recurring_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// The main Recurring Transactions management screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/theme/app_colors.dart';
import '../../core/isar/providers/recurring_providers.dart';
import 'widgets/recurring_card.dart';
import 'widgets/recurring_form_sheet.dart';

class RecurringScreen extends ConsumerWidget {
  const RecurringScreen({super.key});

  void _showAddRule(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const RecurringFormSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsync = ref.watch(activeRecurringRulesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Automations',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: rulesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('Error: $e')),
        data: (rules) {
          if (rules.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 16, bottom: 100),
            itemCount: rules.length,
            itemBuilder: (context, index) {
              final rule = rules[index];
              return RecurringCard(
                rule: rule,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => RecurringFormSheet(rule: rule),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddRule(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.auto_awesome_rounded),
        label: const Text('New Automation', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: AppColors.surfaceVariant, shape: BoxShape.circle),
            child: const Icon(Icons.auto_mode_rounded, size: 48, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 24),
          const Text('Smart Automations', style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Automate your rent, salaries, or SIPs. PaisaPlus will record them for you on schedule.',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () => _showAddRule(context),
            child: const Text('Setup First Automation', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
