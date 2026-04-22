// lib/core/isar/schemas/goal.dart
//
// PaisaPlus – Savings Goal Isar Schema
// -------------------------------------
// Goals represent specific saving targets (e.g., "Emergency Fund", "New Bike").
//
// Design:
//  • targetAmountInPaise — the total goal.
//  • savedAmountInPaise — the current progress.
//  • linkedAccountId — optional; allows associating a goal with a specific
//    bank account or "pot" for automated tracking in later phases.

import 'package:isar/isar.dart';

part 'goal.g.dart';

@Collection()
class Goal {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index()
  late String name;

  late int targetAmountInPaise;
  late int savedAmountInPaise;

  /// Optional deadline for the goal.
  DateTime? targetDate;

  late int iconCodePoint;
  late int colorValue;

  /// Optional: associate this goal with a specific account.
  int? linkedAccountId;

  bool isCompleted = false;
  bool isArchived = false;

  late DateTime createdAt;
  late DateTime updatedAt;
}
