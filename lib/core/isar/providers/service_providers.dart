// lib/core/isar/providers/service_providers.dart
// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers for Phase 2 services.
// Plain FutureProvider / StreamProvider — no riverpod_annotation needed.
// All providers read isarProvider from isar_service.dart (Phase 1 file).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../isar_service.dart';
export '../isar_service.dart';
import '../models/app_settings.dart';
export '../models/app_settings.dart';
import '../services/account_service.dart';
import '../services/category_service.dart';
import '../services/transaction_service.dart';
import '../services/budget_service.dart';
import '../services/goal_service.dart';
import '../services/loan_service.dart';
import '../services/recurring_rule_service.dart';
import '../services/subscription_service.dart';
import '../services/backup_service.dart';
import '../services/sync_service.dart';
import '../schemas/account.dart';
import '../schemas/category.dart';
import '../schemas/transaction.dart';

// ── Service providers ─────────────────────────────────────────────────────────

final transactionServiceProvider =
    FutureProvider<TransactionService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return TransactionService(isar);
});

final accountServiceProvider =
    FutureProvider<AccountService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return AccountService(isar);
});

final categoryServiceProvider =
    FutureProvider<CategoryService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return CategoryService(isar);
});

final budgetServiceProvider =
    FutureProvider<BudgetService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return BudgetService(isar);
});

final goalServiceProvider =
    FutureProvider<GoalService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return GoalService(isar);
});

final loanServiceProvider =
    FutureProvider<LoanService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return LoanService(isar);
});

final recurringRuleServiceProvider =
    FutureProvider<RecurringRuleService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return RecurringRuleService(isar);
});

final subscriptionServiceProvider =
    FutureProvider<SubscriptionService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return SubscriptionService(isar);
});

final backupServiceProvider =
    FutureProvider<BackupService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return BackupService(isar);
});

final syncServiceProvider =
    FutureProvider<SyncService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return SyncService(isar);
});

// ── Reactive stream providers ─────────────────────────────────────────────────

/// Fires whenever any transaction is written. Used by home + list screens.
final watchRecentTransactionsProvider =
    StreamProvider<List<Transaction>>((ref) async* {
  final service = await ref.watch(transactionServiceProvider.future);
  await for (final _ in service.watchAll()) {
    yield await service.getPage(limit: 30);
  }
});

final watchActiveAccountsProvider =
    StreamProvider<List<Account>>((ref) async* {
  final service = await ref.watch(accountServiceProvider.future);
  yield* service.watchActive();
});

final watchExpenseCategoriesProvider =
    StreamProvider<List<Category>>((ref) async* {
  final service = await ref.watch(categoryServiceProvider.future);
  yield* service.watchVisible(CategoryType.expense);
});

final watchIncomeCategoriesProvider =
    StreamProvider<List<Category>>((ref) async* {
  final service = await ref.watch(categoryServiceProvider.future);
  yield* service.watchVisible(CategoryType.income);
});

final watchActiveBudgetsProvider = StreamProvider<void>((ref) async* {
  final service = await ref.watch(budgetServiceProvider.future);
  yield* service.watchBudgets();
});

final watchGoalsProvider = StreamProvider<void>((ref) async* {
  final service = await ref.watch(goalServiceProvider.future);
  yield* service.watchGoals();
});

final watchLoansProvider = StreamProvider<void>((ref) async* {
  final service = await ref.watch(loanServiceProvider.future);
  yield* service.watchLoans();
});

final watchRecurringRulesProvider = StreamProvider<void>((ref) async* {
  final service = await ref.watch(recurringRuleServiceProvider.future);
  yield* service.watchRules();
});

final watchSubscriptionsProvider = StreamProvider<void>((ref) async* {
  final service = await ref.watch(subscriptionServiceProvider.future);
  yield* service.watchSubscriptions();
});

final watchAccountTransactionsProvider =
    StreamProvider.family<List<Transaction>, int>((ref, accountId) async* {
  final service = await ref.watch(transactionServiceProvider.future);
  await for (final _ in service.watchAll()) {
    yield await service.getPageForAccount(accountId: accountId);
  }
});

// ── Computed future providers ─────────────────────────────────────────────────

final netWorthInPaiseProvider = FutureProvider<int>((ref) async {
  ref.watch(watchActiveAccountsProvider);
  final service = await ref.watch(accountServiceProvider.future);
  return service.getNetWorthInPaise();
});

final allAccountBalancesProvider =
    FutureProvider<Map<int, AccountBalance>>((ref) async {
  ref.watch(watchActiveAccountsProvider);
  ref.watch(watchRecentTransactionsProvider);
  final service = await ref.watch(accountServiceProvider.future);
  return service.getAllBalances();
});

final expenseCategoryTreeProvider =
    FutureProvider<List<CategoryNode>>((ref) async {
  ref.watch(watchExpenseCategoriesProvider);
  final service = await ref.watch(categoryServiceProvider.future);
  return service.getCategoryTree(CategoryType.expense);
});

final incomeCategoryTreeProvider =
    FutureProvider<List<CategoryNode>>((ref) async {
  ref.watch(watchIncomeCategoriesProvider);
  final service = await ref.watch(categoryServiceProvider.future);
  return service.getCategoryTree(CategoryType.income);
});

// ── Family providers ──────────────────────────────────────────────────────────

final accountBalanceProvider =
    FutureProvider.family<AccountBalance, int>((ref, accountId) async {
  ref.watch(watchActiveAccountsProvider);
  final service = await ref.watch(accountServiceProvider.future);
  return service.getBalance(accountId);
});

final transactionPageProvider =
    FutureProvider.family<List<Transaction>, int>((ref, page) async {
  ref.watch(watchRecentTransactionsProvider);
  final service = await ref.watch(transactionServiceProvider.future);
  return service.getPage(offset: page * 30, limit: 30);
});

final monthlyExpenseInPaiseProvider =
    FutureProvider.family<int, DateTime>((ref, month) async {
  ref.watch(watchRecentTransactionsProvider);
  final service = await ref.watch(transactionServiceProvider.future);
  final from = DateTime(month.year, month.month, 1);
  final to = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
  return service.getTotalExpenseInPaise(from: from, to: to);
});

final monthlyIncomeInPaiseProvider =
    FutureProvider.family<int, DateTime>((ref, month) async {
  ref.watch(watchRecentTransactionsProvider);
  final service = await ref.watch(transactionServiceProvider.future);
  final from = DateTime(month.year, month.month, 1);
  final to = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
  return service.getTotalIncomeInPaise(from: from, to: to);
});

final monthlyExpensesByCategoryProvider =
    FutureProvider.family<Map<int, int>, DateTime>((ref, month) async {
  ref.watch(watchRecentTransactionsProvider);
  final service = await ref.watch(transactionServiceProvider.future);
  final from = DateTime(month.year, month.month, 1);
  final to = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
  return service.getExpensesByCategoryInPaise(from: from, to: to);
});

final dailyExpenseTotalsProvider =
    FutureProvider.family<Map<DateTime, int>, DateTime>((ref, month) async {
  ref.watch(watchRecentTransactionsProvider);
  final service = await ref.watch(transactionServiceProvider.future);
  final from = DateTime(month.year, month.month, 1);
  final to = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
  return service.getDailyExpenseTotals(from: from, to: to);
});