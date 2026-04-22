// lib/core/isar/providers/subscription_providers.dart
// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers for Subscriptions and Bills.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_providers.dart';
import '../schemas/subscription.dart';

/// Watches all active subscriptions.
final activeSubscriptionsProvider = FutureProvider<List<Subscription>>((ref) async {
  ref.watch(watchSubscriptionsProvider);
  final service = await ref.watch(subscriptionServiceProvider.future);
  return service.getActiveSubscriptions();
});

/// Watches bills due in the next 30 days.
final upcomingBillsProvider = FutureProvider<List<Subscription>>((ref) async {
  ref.watch(watchSubscriptionsProvider);
  final service = await ref.watch(subscriptionServiceProvider.future);
  return service.getUpcomingBills(30);
});

/// Watches total estimated monthly subscription cost.
final monthlySubscriptionCostProvider = FutureProvider<int>((ref) async {
  ref.watch(watchSubscriptionsProvider);
  final service = await ref.watch(subscriptionServiceProvider.future);
  return service.getMonthlySubscriptionCost();
});
