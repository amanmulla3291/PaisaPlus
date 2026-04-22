// lib/core/isar/schemas/recurring_rule.dart
//
// PaisaPlus – Recurring Transaction Rule Isar Schema
// ----------------------------------------------------
// Defines templates for transactions that repeat over time.
//
// Design:
//  • frequency — how often it repeats.
//  • lastGeneratedDate — essential for the generator to know when to stop.
//  • amountInPaise / type / category / account — template data for the txn.

import 'package:isar/isar.dart';
import 'transaction.dart'; // For TransactionType

part 'recurring_rule.g.dart';

enum RecurringFrequency {
  daily,
  weekly,
  biweekly,
  monthly,
  quarterly,
  yearly,
}

@Collection()
class RecurringRule {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index()
  late String name;

  late int amountInPaise;

  @enumerated
  late TransactionType transactionType;

  late int categoryId;
  late int accountId;

  @enumerated
  late RecurringFrequency frequency;

  /// 1-31 for monthly/yearly.
  int? dayOfMonth;

  /// 1-7 for weekly/biweekly.
  int? dayOfWeek;

  late DateTime startDate;
  DateTime? endDate;

  /// Tracks the last time a transaction was automatically created from this rule.
  DateTime? lastGeneratedDate;

  bool isActive = true;

  late DateTime createdAt;
  late DateTime updatedAt;
}
