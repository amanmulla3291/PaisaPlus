// lib/core/isar/schemas/budget.dart
//
// PaisaPlus – Budget Isar Schema
// -------------------------------
// Budgets define spending limits for specific categories or groups of categories
// over a period (usually monthly).
//
// Design:
//  • Linked by categoryIds (List<int>). A budget can cover one or many categories.
//  • Period based: supports monthly (standard), weekly, yearly, or custom ranges.
//  • Rollover: optional carry-over of unspent balance to the next period.
//  • UUID for sync/backup stability.

import 'package:isar/isar.dart';

part 'budget.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Enums
// ─────────────────────────────────────────────────────────────────────────────

enum BudgetPeriod {
  monthly,
  weekly,
  yearly,
  custom,
}

// ─────────────────────────────────────────────────────────────────────────────
// Schema
// ─────────────────────────────────────────────────────────────────────────────

@Collection()
class Budget {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index()
  late String name;

  /// The total spending limit for this budget in paise.
  late int amountInPaise;

  /// The categories this budget applies to.
  /// Transactions in these categories count against this budget.
  late List<int> categoryIds;

  @enumerated
  late BudgetPeriod period;

  /// Start date for custom periods. Null for monthly/weekly/yearly.
  DateTime? startDate;

  /// End date for custom periods. Null for monthly/weekly/yearly.
  DateTime? endDate;

  /// If true, unspent amount from the previous period is added to the current limit.
  bool rolloverEnabled = false;

  /// ARGB color integer for UI charts.
  late int colorValue;

  /// Material Icons codepoint.
  late int iconCodePoint;

  /// Soft-delete/archival flag.
  bool isArchived = false;

  late DateTime createdAt;
  late DateTime updatedAt;
}
