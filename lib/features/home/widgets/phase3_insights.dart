// lib/features/home/widgets/phase3_insights.dart
// ─────────────────────────────────────────────────────────────────────────────
// Phase 3 Dashboard Widgets — Budget & Loan summaries for the Home screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/providers/budget_providers.dart';
import '../../../core/isar/providers/loan_providers.dart';
import '../../../core/isar/providers/subscription_providers.dart';
import '../../../core/isar/providers/service_providers.dart';

class HomePhase3Insights extends ConsumerWidget {
  final DateTime month;
  const HomePhase3Insights({super.key, required this.month});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsAsync = ref.watch(activeBudgetsProvider);
    final totalSpentAsync = ref.watch(monthlyExpenseInPaiseProvider(month));
    final owedAsync = ref.watch(totalOwedProvider);
    final billsAsync = ref.watch(upcomingBillsProvider);

    return Column(
      children: [
        // ── Budget Overview ──────────────────────────────────────────────────
        budgetsAsync.when(
          data: (budgets) {
            if (budgets.isEmpty) return const SizedBox.shrink();
            final totalBudget = budgets.fold<int>(0, (sum, b) => sum + b.amountInPaise);
            final totalSpent = totalSpentAsync.value ?? 0;
            final progress = totalBudget == 0 ? 0.0 : totalSpent / totalBudget;
            
            return _InsightCard(
              title: 'Budget Status',
              icon: Icons.pie_chart_rounded,
              color: AppColors.primary,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${NumberFormat('#,##,###').format(totalSpent / 100)} / ₹${NumberFormat('#,##,###').format(totalBudget / 100)}',
                        style: const TextStyle(fontFamily: 'Nunito', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: TextStyle(fontFamily: 'Nunito', fontSize: 16, fontWeight: FontWeight.w800, color: progress > 1.0 ? AppColors.error : AppColors.success),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    backgroundColor: AppColors.surfaceVariant,
                    color: progress > 1.0 ? AppColors.error : AppColors.primary,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),

        const SizedBox(height: 12),

        // ── Loans & Upcoming Bills ──────────────────────────────────────────
        Row(
          children: [
            // Net Debt/Asset
            Expanded(
              child: owedAsync.when(
                data: (owed) => _SmallInsight(
                  title: 'Net Debt',
                  value: '₹${NumberFormat('#,##,###').format(owed / 100)}',
                  icon: Icons.handshake_rounded,
                  color: AppColors.error,
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 12),
            // Upcoming Bills
            Expanded(
              child: billsAsync.when(
                data: (bills) => _SmallInsight(
                  title: 'Bills (30d)',
                  value: bills.isEmpty ? 'All paid' : '${bills.length} pending',
                  icon: Icons.calendar_today_rounded,
                  color: AppColors.info,
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget child;

  const _InsightCard({required this.title, required this.icon, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _SmallInsight extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SmallInsight({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontFamily: 'Nunito', fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}
