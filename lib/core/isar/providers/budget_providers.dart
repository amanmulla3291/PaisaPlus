// lib/core/isar/providers/budget_providers.dart
// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers for the Budgets feature.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_providers.dart';
import '../schemas/budget.dart';
import '../services/budget_service.dart';

/// Watches all active (non-archived) budgets.
final activeBudgetsProvider = FutureProvider<List<Budget>>((ref) async {
  // Re-run this future whenever the budgets collection changes
  ref.watch(watchActiveBudgetsProvider);
  
  final service = await ref.watch(budgetServiceProvider.future);
  return service.getActiveBudgets();
});

/// Watches progress for a specific budget in a specific month.
final budgetProgressProvider =
    FutureProvider.family<BudgetProgress, ({int budgetId, DateTime month})>(
        (ref, arg) async {
  // Re-run whenever budgets OR transactions change
  ref.watch(watchActiveBudgetsProvider);
  ref.watch(watchRecentTransactionsProvider);

  final service = await ref.watch(budgetServiceProvider.future);
  return service.getBudgetProgress(arg.budgetId, arg.month);
});
