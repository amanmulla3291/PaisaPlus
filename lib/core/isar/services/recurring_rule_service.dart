// lib/core/isar/services/recurring_rule_service.dart
//
// PaisaPlus – RecurringRuleService
// ---------------------------------
// Handles recurring transaction templates and auto-generation.

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/recurring_rule.dart';
import '../schemas/transaction.dart';

const _uuid = Uuid();

class RecurringRuleService {
  final Isar _isar;
  RecurringRuleService(this._isar);

  // ── WRITES ────────────────────────────────────────────────────────────────

  Future<Id> createRule(RecurringRule rule) async {
    final now = DateTime.now();
    rule
      ..uuid = _uuid.v4()
      ..createdAt = now
      ..updatedAt = now;
    return _isar.writeTxn(() => _isar.recurringRules.put(rule));
  }

  Future<void> updateRule(RecurringRule rule) async {
    rule.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.recurringRules.put(rule));
  }

  Future<void> toggleActive(Id id) async {
    await _isar.writeTxn(() async {
      final rule = await _isar.recurringRules.get(id);
      if (rule != null) {
        rule.isActive = !rule.isActive;
        rule.updatedAt = DateTime.now();
        await _isar.recurringRules.put(rule);
      }
    });
  }

  /// The heavy lifter: scans active rules and creates transactions for missed dates.
  /// Called on app startup or manual refresh.
  Future<int> generateDueTransactions() async {
    final activeRules = await _isar.recurringRules.filter().isActiveEqualTo(true).findAll();
    final today = DateTime.now();
    int count = 0;

    await _isar.writeTxn(() async {
      for (final rule in activeRules) {
        DateTime lastGen = rule.lastGeneratedDate ?? rule.startDate;
        DateTime nextDate = _calculateNextOccurrence(lastGen, rule.frequency);

        while (nextDate.isBefore(today) || _isSameDay(nextDate, today)) {
          // If there's an end date, check it
          if (rule.endDate != null && nextDate.isAfter(rule.endDate!)) break;

          // Create the transaction
          final txn = Transaction()
            ..uuid = _uuid.v4()
            ..amountInPaise = rule.amountInPaise
            ..type = rule.transactionType
            ..accountId = rule.accountId
            ..categoryId = rule.categoryId
            ..recurringRuleId = rule.id
            ..entryMode = TransactionEntryMode.recurring
            ..note = 'Recurring: ${rule.name}'
            ..transactionDate = nextDate
            ..createdAt = DateTime.now()
            ..updatedAt = DateTime.now();

          await _isar.transactions.put(txn);
          
          rule.lastGeneratedDate = nextDate;
          nextDate = _calculateNextOccurrence(nextDate, rule.frequency);
          count++;
        }
        await _isar.recurringRules.put(rule);
      }
    });

    return count;
  }

  // ── READS ─────────────────────────────────────────────────────────────────

  Future<RecurringRule?> getById(Id id) => _isar.recurringRules.get(id);

  Future<List<RecurringRule>> getActiveRules() async {
    return _isar.recurringRules.filter().isActiveEqualTo(true).findAll();
  }

  // ── HELPERS ───────────────────────────────────────────────────────────────

  DateTime _calculateNextOccurrence(DateTime current, RecurringFrequency freq) {
    switch (freq) {
      case RecurringFrequency.daily:
        return current.add(const Duration(days: 1));
      case RecurringFrequency.weekly:
        return current.add(const Duration(days: 7));
      case RecurringFrequency.biweekly:
        return current.add(const Duration(days: 14));
      case RecurringFrequency.monthly:
        return DateTime(current.year, current.month + 1, current.day);
      case RecurringFrequency.quarterly:
        return DateTime(current.year, current.month + 3, current.day);
      case RecurringFrequency.yearly:
        return DateTime(current.year + 1, current.month, current.day);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // ── WATCH ─────────────────────────────────────────────────────────────────

  Stream<void> watchRules() => _isar.recurringRules.watchLazy();
}
