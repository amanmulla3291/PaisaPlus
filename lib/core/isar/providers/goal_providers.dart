// lib/core/isar/providers/goal_providers.dart
// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers for the Goals feature.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_providers.dart';
import '../schemas/goal.dart';

/// Watches all active (non-completed, non-archived) goals.
final activeGoalsProvider = FutureProvider<List<Goal>>((ref) async {
  ref.watch(watchGoalsProvider);
  final service = await ref.watch(goalServiceProvider.future);
  return service.getActiveGoals();
});

/// Watches all completed goals.
final completedGoalsProvider = FutureProvider<List<Goal>>((ref) async {
  ref.watch(watchGoalsProvider);
  final service = await ref.watch(goalServiceProvider.future);
  return service.getCompletedGoals();
});
