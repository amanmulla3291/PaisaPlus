// lib/core/isar/schemas/subscription.dart
//
// PaisaPlus – Subscription Isar Schema
// -------------------------------------
// Specifically tracks fixed-cost digital services (Netflix, Spotify, etc.).
// While similar to RecurringRule, Subscriptions are distinct in the UI
// (Timeline view) and often have reminders.
//
// Design:
//  • nextBillingDate — used for the "Upcoming Bills" dashboard card.
//  • reminderDaysBefore — allows triggering a notification before the charge.

import 'package:isar/isar.dart';
import 'recurring_rule.dart'; // For RecurringFrequency

part 'subscription.g.dart';

@Collection()
class Subscription {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index()
  late String serviceName;

  late int amountInPaise;

  @enumerated
  late RecurringFrequency frequency;

  late int categoryId;
  late int accountId;

  @Index()
  late DateTime nextBillingDate;

  /// How many days before billing to show a reminder.
  int reminderDaysBefore = 1;

  late int iconCodePoint;
  late int colorValue;

  bool isActive = true;

  late DateTime createdAt;
  late DateTime updatedAt;
}
