// lib/core/isar/schemas/account.dart
//
// PaisaPlus – Account Isar Schema
// ---------------------------------
// Accounts represent real-world money containers: Cash wallet, bank account,
// UPI-linked account, credit card, digital wallet (PhonePe, Paytm), etc.
//
// Design decisions:
//  • openingBalanceInPaise — seeded by user at account creation. The "true"
//    balance at any moment = openingBalance + Σ(income transactions) –
//    Σ(expense transactions) for this accountId. No denormalised balance field
//    to avoid sync bugs. The AccountService computes running balance on demand.
//    For credit cards: openingBalance is typically 0 or the existing outstanding.
//  • creditLimitInPaise — only meaningful for AccountType.creditCard.
//    Enables the "Available Credit" chip on the home dashboard.
//  • isExcludedFromTotal — user can exclude an account from "Net Worth" /
//    "Total Balance" calculations. Common use-case: a joint account they track
//    but don't own fully, or a loan disbursement account.
//  • colorValue / iconCodePoint — same pattern as Category. Each account gets
//    a distinctive color shown on transaction cards for quick visual scanning.
//  • sortOrder — user controls order in account picker and home cards.
//  • isArchived — accounts with zero balance that user no longer uses.
//    Archived accounts still appear in historical data but not in the add-
//    transaction picker.

import 'package:isar/isar.dart';

part 'account.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Enums
// ─────────────────────────────────────────────────────────────────────────────

/// The type of real-world account this represents.
/// Drives UI behaviour (credit limit chip, interest rate field, etc.)
enum AccountType {
  cash,           // Physical cash wallet
  bankAccount,    // Savings / current bank account
  creditCard,     // Credit card (tracks outstanding + limit)
  digitalWallet,  // PhonePe, Paytm, Amazon Pay, etc.
  investment,     // Mutual fund, stock demat account (read-only balance tracking)
  loan,           // Track a loan the user has taken (negative balance expected)
  other,
}

// ─────────────────────────────────────────────────────────────────────────────
// Schema
// ─────────────────────────────────────────────────────────────────────────────

@Collection()
class Account {
  // ── Identity ───────────────────────────────────────────────────────────────
  Id id = Isar.autoIncrement;

  /// Stable UUID — for backup/restore and future export.
  @Index(unique: true)
  late String uuid;

  // ── Display ────────────────────────────────────────────────────────────────

  /// User-facing account name. Examples: "HDFC Savings", "SBI Credit Card",
  /// "PhonePe Wallet", "Cash", "Petty Cash"
  @Index()
  late String name;

  /// Material Icons codepoint for the account icon.
  /// Cash → Icons.wallet, Bank → Icons.account_balance,
  /// Credit → Icons.credit_card, etc.
  late int iconCodePoint;

  /// ARGB color integer. Each account gets a unique color for quick scanning.
  late int colorValue;

  // ── Type ───────────────────────────────────────────────────────────────────

  @enumerated
  late AccountType type;

  // ── Balances (all in paise) ────────────────────────────────────────────────

  /// The balance when this account was first added to PaisaPlus.
  /// Used as the base for running balance calculation.
  /// For credit cards: typically 0 (or existing outstanding as a negative value).
  /// For loans: the disbursed amount as a positive value (represents what's owed).
  late int openingBalanceInPaise;

  /// The date as of which openingBalance is accurate.
  /// Transactions before this date are excluded from balance calc (data not entered yet).
  late DateTime openingBalanceDate;

  /// Credit limit in paise — only set for AccountType.creditCard.
  /// Null for all other account types.
  int? creditLimitInPaise;

  // ── Bank Details (optional — user-entered for reference, NOT verified) ─────

  /// Last 4 digits of card/account number. User-entered. Never full number.
  /// Used only for display: "HDFC ••••4521"
  String? accountNumberLast4;

  /// Bank name. Free text. Example: "HDFC Bank", "State Bank of India"
  String? bankName;

  /// IFSC code — optional, for user's own reference.
  String? ifscCode;

  /// For credit cards: billing cycle date (day of month, 1–31).
  /// Used in Phase 3 to show "statement due in X days" chip.
  int? billingCycleDay;

  /// For credit cards: payment due date relative to statement (e.g. 15 days after).
  int? paymentDueDays;

  /// Annual interest rate as a percentage × 100 (integer).
  /// Example: 36.50% → 3650. Null if not applicable.
  /// Used for Phase 3 loan interest calculation.
  int? interestRatePercent100;

  // ── Behaviour Flags ────────────────────────────────────────────────────────

  /// When true, this account's balance is excluded from "Total Balance" and
  /// "Net Worth" calculations on the home dashboard.
  bool isExcludedFromTotal = false;

  /// When true, account no longer appears in the transaction entry picker
  /// but remains visible in historical data and reports.
  bool isArchived = false;

  // ── Ordering ───────────────────────────────────────────────────────────────

  /// Explicit display order on home dashboard account cards.
  int sortOrder = 0;

  // ── Timestamps ─────────────────────────────────────────────────────────────
  late DateTime createdAt;
  late DateTime updatedAt;

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// True if this is a credit-type account where balance can go negative.
  bool get isCreditType =>
      type == AccountType.creditCard || type == AccountType.loan;

  /// Credit limit as double INR for display.
  double? get creditLimitInRupees =>
      creditLimitInPaise != null ? creditLimitInPaise! / 100.0 : null;

  /// Opening balance as double INR for display calculations.
  double get openingBalanceInRupees => openingBalanceInPaise / 100.0;
}