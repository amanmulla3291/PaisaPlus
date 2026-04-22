// lib/core/isar/services/subscription_service.dart
//
// PaisaPlus – SubscriptionService
// ------------------------------
// Handles digital subscriptions and bill tracking.

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/subscription.dart';
import '../schemas/recurring_rule.dart'; // For RecurringFrequency

const _uuid = Uuid();

class SubscriptionService {
  final Isar _isar;
  SubscriptionService(this._isar);

  // ── WRITES ────────────────────────────────────────────────────────────────

  Future<Id> createSubscription(Subscription sub) async {
    final now = DateTime.now();
    sub
      ..uuid = _uuid.v4()
      ..createdAt = now
      ..updatedAt = now;
    return _isar.writeTxn(() => _isar.subscriptions.put(sub));
  }

  Future<void> updateSubscription(Subscription sub) async {
    sub.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.subscriptions.put(sub));
  }

  Future<void> deleteSubscription(Id id) async {
    await _isar.writeTxn(() => _isar.subscriptions.delete(id));
  }

  // ── READS ─────────────────────────────────────────────────────────────────

  Future<Subscription?> getById(Id id) => _isar.subscriptions.get(id);

  Future<List<Subscription>> getActiveSubscriptions() async {
    return _isar.subscriptions.filter().isActiveEqualTo(true).findAll();
  }

  Future<List<Subscription>> getUpcomingBills(int days) async {
    final today = DateTime.now();
    final limit = today.add(Duration(days: days));
    return _isar.subscriptions
        .filter()
        .isActiveEqualTo(true)
        .and()
        .nextBillingDateBetween(today, limit)
        .sortByNextBillingDate()
        .findAll();
  }

  Future<int> getMonthlySubscriptionCost() async {
    final active = await getActiveSubscriptions();
    int total = 0;
    for (final sub in active) {
      switch (sub.frequency) {
        case RecurringFrequency.daily:
          total += sub.amountInPaise * 30;
        case RecurringFrequency.weekly:
          total += sub.amountInPaise * 4;
        case RecurringFrequency.biweekly:
          total += sub.amountInPaise * 2;
        case RecurringFrequency.monthly:
          total += sub.amountInPaise;
        case RecurringFrequency.quarterly:
          total += sub.amountInPaise ~/ 3;
        case RecurringFrequency.yearly:
          total += sub.amountInPaise ~/ 12;
      }
    }
    return total;
  }

  // ── WATCH ─────────────────────────────────────────────────────────────────

  Stream<void> watchSubscriptions() => _isar.subscriptions.watchLazy();
}
