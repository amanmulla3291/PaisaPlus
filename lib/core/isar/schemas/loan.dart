// lib/core/isar/schemas/loan.dart
//
// PaisaPlus – Loan/Debt Isar Schema
// ----------------------------------
// Tracks money borrowed from others or lent to others.
//
// Design:
//  • loanType — borrowed (debt) vs lent (asset).
//  • interestRatePercent100 — stored as int (percentage * 100) to avoid floats.
//    Example: 12.5% is stored as 1250.
//  • linkedAccountId — the account used to receive/disburse the loan.

import 'package:isar/isar.dart';

part 'loan.g.dart';

enum LoanType {
  borrowed,
  lent,
}

@Collection()
class Loan {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index()
  late String name;

  late int principalAmountInPaise;
  late int outstandingAmountInPaise;

  /// Interest rate * 100. (e.g. 1250 = 12.50%).
  int? interestRatePercent100;

  @enumerated
  late LoanType loanType;

  /// Name of the person/entity (e.g. "HDFC Bank", "Aman").
  @Index()
  late String personName;

  /// Optional contact info (phone/email).
  String? personContact;

  late DateTime startDate;
  DateTime? dueDate;

  /// Account linked to this loan for payments.
  int? linkedAccountId;

  bool isSettled = false;

  late DateTime createdAt;
  late DateTime updatedAt;
}
