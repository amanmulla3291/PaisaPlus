// lib/core/isar/services/goal_service.dart
//
// PaisaPlus – GoalService
// -----------------------
// Handles savings goals and tracking progress.

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/goal.dart';

const _uuid = Uuid();

class GoalService {
  final Isar _isar;
  GoalService(this._isar);

  // ── WRITES ────────────────────────────────────────────────────────────────

  Future<Id> createGoal(Goal goal) async {
    final now = DateTime.now();
    goal
      ..uuid = _uuid.v4()
      ..createdAt = now
      ..updatedAt = now;
    return _isar.writeTxn(() => _isar.goals.put(goal));
  }

  Future<void> updateGoal(Goal goal) async {
    goal.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.goals.put(goal));
  }

  Future<void> addToGoal(Id goalId, int amountInPaise) async {
    await _isar.writeTxn(() async {
      final goal = await _isar.goals.get(goalId);
      if (goal != null) {
        goal.savedAmountInPaise += amountInPaise;
        if (goal.savedAmountInPaise >= goal.targetAmountInPaise) {
          goal.isCompleted = true;
        }
        goal.updatedAt = DateTime.now();
        await _isar.goals.put(goal);
      }
    });
  }

  Future<void> archiveGoal(Id id) async {
    final goal = await _isar.goals.get(id);
    if (goal == null) return;
    goal
      ..isArchived = true
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.goals.put(goal));
  }

  // ── READS ─────────────────────────────────────────────────────────────────

  Future<Goal?> getById(Id id) => _isar.goals.get(id);

  Future<List<Goal>> getActiveGoals() async {
    return _isar.goals
        .filter()
        .isArchivedEqualTo(false)
        .and()
        .isCompletedEqualTo(false)
        .findAll();
  }

  Future<List<Goal>> getCompletedGoals() async {
    return _isar.goals
        .filter()
        .isArchivedEqualTo(false)
        .and()
        .isCompletedEqualTo(true)
        .findAll();
  }

  // ── WATCH ─────────────────────────────────────────────────────────────────

  Stream<void> watchGoals() => _isar.goals.watchLazy();
}
