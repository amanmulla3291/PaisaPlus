// lib/core/isar/services/loan_service.dart
//
// PaisaPlus – LoanService
// -----------------------
// Handles loan tracking and repayments.

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/loan.dart';
import '../schemas/transaction.dart';

const _uuid = Uuid();

class LoanService {
  final Isar _isar;
  LoanService(this._isar);

  // ── WRITES ────────────────────────────────────────────────────────────────

  Future<Id> createLoan(Loan loan) async {
    final now = DateTime.now();
    loan
      ..uuid = _uuid.v4()
      ..createdAt = now
      ..updatedAt = now;
    return _isar.writeTxn(() => _isar.loans.put(loan));
  }

  Future<void> updateLoan(Loan loan) async {
    loan.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.loans.put(loan));
  }

  /// Records a payment towards a loan.
  /// Also creates a corresponding transaction in the ledger.
  Future<void> recordPayment({
    required Id loanId,
    required int amountInPaise,
    required int accountId,
    required int categoryId,
    DateTime? date,
    String? note,
  }) async {
    await _isar.writeTxn(() async {
      final loan = await _isar.loans.get(loanId);
      if (loan == null) return;

      // 1. Update loan balance
      loan.outstandingAmountInPaise -= amountInPaise;
      if (loan.outstandingAmountInPaise <= 0) {
        loan.outstandingAmountInPaise = 0;
        loan.isSettled = true;
      }
      loan.updatedAt = DateTime.now();
      await _isar.loans.put(loan);

      // 2. Create ledger transaction
      final txn = Transaction()
        ..uuid = _uuid.v4()
        ..amountInPaise = amountInPaise
        ..type = loan.loanType == LoanType.borrowed
            ? TransactionType.expense
            : TransactionType.income
        ..accountId = accountId
        ..categoryId = categoryId
        ..loanId = loanId
        ..note = note ?? 'Loan payment: ${loan.name}'
        ..transactionDate = date ?? DateTime.now()
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
      
      await _isar.transactions.put(txn);
    });
  }

  Future<void> settleLoan(Id loanId) async {
    await _isar.writeTxn(() async {
      final loan = await _isar.loans.get(loanId);
      if (loan != null) {
        loan.isSettled = true;
        loan.outstandingAmountInPaise = 0;
        loan.updatedAt = DateTime.now();
        await _isar.loans.put(loan);
      }
    });
  }

  // ── READS ─────────────────────────────────────────────────────────────────

  Future<Loan?> getById(Id id) => _isar.loans.get(id);

  Future<List<Loan>> getActiveBorrowed() async {
    return _isar.loans
        .filter()
        .isSettledEqualTo(false)
        .and()
        .loanTypeEqualTo(LoanType.borrowed)
        .findAll();
  }

  Future<List<Loan>> getActiveLent() async {
    return _isar.loans
        .filter()
        .isSettledEqualTo(false)
        .and()
        .loanTypeEqualTo(LoanType.lent)
        .findAll();
  }

  Future<int> getTotalOwed() async {
    final loans = await getActiveBorrowed();
    return loans.fold<int>(0, (int sum, Loan l) => sum + l.outstandingAmountInPaise);
  }

  Future<int> getTotalLent() async {
    final loans = await getActiveLent();
    return loans.fold<int>(0, (int sum, Loan l) => sum + l.outstandingAmountInPaise);
  }

  // ── WATCH ─────────────────────────────────────────────────────────────────

  Stream<void> watchLoans() => _isar.loans.watchLazy();
}
