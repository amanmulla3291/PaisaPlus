// lib/core/isar/providers/recurring_providers.dart
// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers for Recurring Transactions.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_providers.dart';
import '../schemas/recurring_rule.dart';

/// Watches all active recurring rules.
final activeRecurringRulesProvider = FutureProvider<List<RecurringRule>>((ref) async {
  ref.watch(watchRecurringRulesProvider);
  final service = await ref.watch(recurringRuleServiceProvider.future);
  return service.getActiveRules();
});
