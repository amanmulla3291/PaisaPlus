// lib/features/home/widgets/kpi_row.dart
//
// PaisaPlus – KPI Row
// ---------------------
// Three compact metric tiles below the balance card:
//   Left:   Avg daily spend this month
//   Centre: Transactions count this month
//   Right:  Largest single expense this month
//
// These give a quick "health check" without needing to open Reports.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/schemas/transaction.dart';
import '../../../shared/theme/app_colors.dart';

class KpiRow extends ConsumerWidget {
  final DateTime selectedMonth;

  const KpiRow({super.key, required this.selectedMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseAsync =
        ref.watch(monthlyExpenseInPaiseProvider(selectedMonth));

    // We also need the raw transactions for count + largest.
    // Watch the recent stream and compute locally — cheap for a month's data.
    final txnAsync = ref.watch(watchRecentTransactionsProvider);

    return txnAsync.when(
      loading: () => _shimmerRow(),
      error: (_, __) => const SizedBox.shrink(),
      data: (allTxns) {
        // Filter to selected month, non-deleted, expense only
        final monthStart = DateTime(selectedMonth.year, selectedMonth.month, 1);
        final monthEnd =
            DateTime(selectedMonth.year, selectedMonth.month + 1, 0, 23, 59, 59);

        final monthExpenses = allTxns.where((t) =>
            !t.isDeleted &&
            t.type == TransactionType.expense &&
            !t.transactionDate.isBefore(monthStart) &&
            !t.transactionDate.isAfter(monthEnd)).toList();

        final count = monthExpenses.length;

        final daysInMonth = monthEnd.day;
        final daysPassed = selectedMonth.month == DateTime.now().month
            ? DateTime.now().day
            : daysInMonth;

        return expenseAsync.when(
          loading: () => _shimmerRow(),
          error: (_, __) => const SizedBox.shrink(),
          data: (totalExpenseP) {
            final avgDailyP =
                daysPassed > 0 ? totalExpenseP ~/ daysPassed : 0;
            final largestP = monthExpenses.isNotEmpty
                ? monthExpenses
                    .map((t) => t.amountInPaise)
                    .reduce((a, b) => a > b ? a : b)
                : 0;

            final isPrivate = ref.watch(privacyModeProvider);

            return Row(
              children: [
                _KpiTile(
                  label: 'Avg / Day',
                  value: isPrivate ? '••••' : '₹${_fmt(avgDailyP)}',
                  icon: Icons.trending_flat_rounded,
                  iconColor: AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                _KpiTile(
                  label: 'Transactions',
                  value: isPrivate ? '••' : count.toString(),
                  icon: Icons.receipt_long_outlined,
                  iconColor: AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                _KpiTile(
                  label: 'Largest',
                  value: isPrivate ? '••••' : '₹${_fmt(largestP)}',
                  icon: Icons.arrow_upward_rounded,
                  iconColor: AppColors.primary,
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _fmt(int paise) {
    final rupees = paise / 100.0;
    if (rupees >= 100000) {
      return '${(rupees / 100000).toStringAsFixed(1)}L';
    }
    if (rupees >= 1000) {
      return '${(rupees / 1000).toStringAsFixed(1)}K';
    }
    return NumberFormat('#,##0', 'en_IN').format(rupees);
  }

  Widget _shimmerRow() {
    return Row(
      children: List.generate(
        3,
        (_) => Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _KpiTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: iconColor),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary)),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}