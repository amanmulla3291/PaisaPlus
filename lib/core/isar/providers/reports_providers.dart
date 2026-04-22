// lib/core/isar/providers/reports_providers.dart
// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers for data aggregation used in Reports & Analytics charts.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_providers.dart';

/// Aggregates daily expense and income for a specific month.
/// Returns a map of DayOfMonth -> (Income, Expense).
final cashFlowTrendProvider =
    FutureProvider.family<Map<int, ({int income, int expense})>, DateTime>(
        (ref, month) async {
  // Watch for changes
  ref.watch(watchRecentTransactionsProvider);
  
  final service = await ref.watch(transactionServiceProvider.future);
  final from = DateTime(month.year, month.month, 1);
  final to = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

  final dailyExpenses = await service.getDailyExpenseTotals(from: from, to: to);
  final dailyIncome = await service.getDailyIncomeTotals(from: from, to: to);

  final Map<int, ({int income, int expense})> result = {};
  
  // Fill all days of the month to ensure no gaps in the line chart
  final daysInMonth = to.day;
  for (int i = 1; i <= daysInMonth; i++) {
    final dayKey = DateTime(month.year, month.month, i);
    result[i] = (
      income: dailyIncome[dayKey] ?? 0,
      expense: dailyExpenses[dayKey] ?? 0,
    );
  }

  return result;
});

/// Aggregates total spending per category for a specific month.
final categorySpendingProvider =
    FutureProvider.family<Map<int, int>, DateTime>((ref, month) async {
  ref.watch(watchRecentTransactionsProvider);
  
  final service = await ref.watch(transactionServiceProvider.future);
  final from = DateTime(month.year, month.month, 1);
  final to = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

  return service.getExpensesByCategoryInPaise(from: from, to: to);
});

/// Computes the average daily burn for the month.
final averageDailyBurnProvider =
    FutureProvider.family<double, DateTime>((ref, month) async {
  final spending = await ref.watch(categorySpendingProvider(month).future);
  final totalPaise = spending.values.fold<int>(0, (sum, val) => sum + val);
  
  final now = DateTime.now();
  final isCurrentMonth = month.year == now.year && month.month == now.month;
  final days = isCurrentMonth ? now.day : DateTime(month.year, month.month + 1, 0).day;
  
  return (totalPaise / 100.0) / days;
});
