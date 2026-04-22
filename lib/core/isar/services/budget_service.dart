// lib/core/isar/services/budget_service.dart
//
// PaisaPlus – BudgetService
// --------------------------
// Handles all budget-related Isar operations, including spent calculation.

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/budget.dart';
import '../schemas/transaction.dart';

const _uuid = Uuid();

class BudgetProgress {
  final Budget budget;
  final int spentInPaise;
  final int allocatedInPaise;

  const BudgetProgress({
    required this.budget,
    required this.spentInPaise,
    required this.allocatedInPaise,
  });

  double get progressPercentage =>
      allocatedInPaise == 0 ? 0 : spentInPaise / allocatedInPaise;

  int get remainingInPaise => allocatedInPaise - spentInPaise;

  bool get isOverBudget => spentInPaise > allocatedInPaise;
}

class BudgetService {
  final Isar _isar;
  BudgetService(this._isar);

  // ── WRITES ────────────────────────────────────────────────────────────────

  Future<Id> createBudget(Budget budget) async {
    final now = DateTime.now();
    budget
      ..uuid = _uuid.v4()
      ..createdAt = now
      ..updatedAt = now;
    return _isar.writeTxn(() => _isar.budgets.put(budget));
  }

  Future<void> updateBudget(Budget budget) async {
    budget.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.budgets.put(budget));
  }

  Future<void> archiveBudget(Id id) async {
    final budget = await _isar.budgets.get(id);
    if (budget == null) return;
    budget
      ..isArchived = true
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.budgets.put(budget));
  }

  Future<void> deleteBudget(Id id) async {
    await _isar.writeTxn(() => _isar.budgets.delete(id));
  }

  // ── READS ─────────────────────────────────────────────────────────────────

  Future<Budget?> getById(Id id) => _isar.budgets.get(id);

  Future<List<Budget>> getActiveBudgets() async {
    return _isar.budgets.filter().isArchivedEqualTo(false).findAll();
  }

  Future<List<Budget>> getAllBudgets() async {
    return _isar.budgets.where().findAll();
  }

  // ── PROGRESS CALCULATION ──────────────────────────────────────────────────

  /// Calculates how much has been spent for a budget in a specific month.
  Future<BudgetProgress> getBudgetProgress(Id budgetId, DateTime month) async {
    final budget = await _isar.budgets.get(budgetId);
    if (budget == null) throw StateError('Budget $budgetId not found');

    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    if (budget.categoryIds.isEmpty) {
      return BudgetProgress(
        budget: budget,
        spentInPaise: 0,
        allocatedInPaise: budget.amountInPaise,
      );
    }

    final query = _isar.transactions
        .where()
        .transactionDateBetween(startOfMonth, endOfMonth)
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .typeEqualTo(TransactionType.expense)
        .and()
        .group((q) {
      var result = q.categoryIdEqualTo(budget.categoryIds[0]);
      for (var i = 1; i < budget.categoryIds.length; i++) {
        result = result.or().categoryIdEqualTo(budget.categoryIds[i]);
      }
      return result;
    });

    final txns = await query.findAll();
    int spent = 0;
    for (final txn in txns) {
      spent += txn.amountInPaise;
    }

    return BudgetProgress(
      budget: budget,
      spentInPaise: spent,
      allocatedInPaise: budget.amountInPaise,
    );
  }

  // ── WATCH ─────────────────────────────────────────────────────────────────

  Stream<void> watchBudgets() => _isar.budgets.watchLazy();
}
