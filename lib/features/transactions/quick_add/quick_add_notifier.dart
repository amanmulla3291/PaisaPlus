// lib/features/transactions/quick_add/quick_add_notifier.dart
// ─────────────────────────────────────────────────────────────────────────────
// Plain StateNotifier — no riverpod_annotation, matches Phase 1 style.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/schemas/transaction.dart';


// ── Result type ───────────────────────────────────────────────────────────────

sealed class QuickAddResult {}

class QuickAddSuccess extends QuickAddResult {
  final int savedId;
  QuickAddSuccess(this.savedId);
}

class QuickAddError extends QuickAddResult {
  final String message;
  QuickAddError(this.message);
}

// ── State ─────────────────────────────────────────────────────────────────────

class QuickAddState {
  final TransactionType type;
  final String amountString;
  final int? categoryId;
  final int? accountId;
  final int? toAccountId;
  final DateTime transactionDate;
  final String note;
  final String payee;
  final List<String> tags;
  final bool isSaving;

  QuickAddState({
    this.type = TransactionType.expense,
    this.amountString = '',
    this.categoryId,
    this.accountId,
    this.toAccountId,
    DateTime? transactionDate,
    this.note = '',
    this.payee = '',
    this.tags = const [],
    this.isSaving = false,
  }) : transactionDate = transactionDate ?? _today();

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  int get amountInPaise => int.tryParse(amountString) ?? 0;
  double get amountInRupees => amountInPaise / 100.0;
  bool get hasAmount => amountInPaise > 0;
  bool get hasCategory => categoryId != null;
  bool get hasAccount => accountId != null;
  bool get isTransfer => type == TransactionType.transfer;

  bool get canSave {
    if (!hasAmount || !hasCategory || !hasAccount) return false;
    if (isTransfer && toAccountId == null) return false;
    if (isTransfer && toAccountId == accountId) return false;
    return true;
  }

  String get displayAmount {
    if (amountString.isEmpty) return '0';
    final paise = amountInPaise;
    final rupees = paise ~/ 100;
    final cents = paise % 100;
    return '${_fmtIndian(rupees)}.${cents.toString().padLeft(2, '0')}';
  }

  String _fmtIndian(int n) {
    if (n == 0) return '0';
    final s = n.toString();
    if (s.length <= 3) return s;
    final last3 = s.substring(s.length - 3);
    final rest = s.substring(0, s.length - 3);
    final buf = StringBuffer(last3);
    for (int i = rest.length - 1, c = 0; i >= 0; i--, c++) {
      if (c > 0 && c % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return buf.toString().split('').reversed.join();
  }

  static const _s = Object();

  QuickAddState copyWith({
    TransactionType? type,
    String? amountString,
    Object? categoryId = _s,
    Object? accountId = _s,
    Object? toAccountId = _s,
    DateTime? transactionDate,
    String? note,
    String? payee,
    List<String>? tags,
    bool? isSaving,
  }) {
    return QuickAddState(
      type: type ?? this.type,
      amountString: amountString ?? this.amountString,
      categoryId: categoryId == _s ? this.categoryId : categoryId as int?,
      accountId: accountId == _s ? this.accountId : accountId as int?,
      toAccountId:
          toAccountId == _s ? this.toAccountId : toAccountId as int?,
      transactionDate: transactionDate ?? this.transactionDate,
      note: note ?? this.note,
      payee: payee ?? this.payee,
      tags: tags ?? this.tags,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class QuickAddNotifier extends StateNotifier<QuickAddState> {
  final Ref _ref;

  QuickAddNotifier(this._ref) : super(QuickAddState());

  void setType(TransactionType type) {
    state = state.copyWith(
      type: type,
      categoryId: null,
      toAccountId: null,
    );
  }

  void pressDigit(String digit) {
    if (state.amountString.length >= 8) return;
    if (state.amountString.isEmpty && digit == '0') return;
    HapticFeedback.selectionClick();
    state = state.copyWith(amountString: state.amountString + digit);
  }

  void pressBackspace() {
    if (state.amountString.isEmpty) return;
    HapticFeedback.selectionClick();
    state = state.copyWith(
        amountString:
            state.amountString.substring(0, state.amountString.length - 1));
  }

  void pressClear() {
    HapticFeedback.mediumImpact();
    state = state.copyWith(amountString: '');
  }

  void setCategory(int id) => state = state.copyWith(categoryId: id);
  void setAccount(int id) => state = state.copyWith(accountId: id);
  void setToAccount(int id) => state = state.copyWith(toAccountId: id);
  void setDate(DateTime date) => state = state.copyWith(transactionDate: date);
  void setNote(String note) => state = state.copyWith(note: note);
  void setPayee(String payee) => state = state.copyWith(payee: payee);

  void reset() {
    final t = state.type;
    final a = state.accountId;
    state = QuickAddState(type: t, accountId: a);
  }

  Future<QuickAddResult> save() async {
    if (!state.canSave) return QuickAddError(_validationMsg());
    state = state.copyWith(isSaving: true);

    try {
      final txnService = await _ref.read(transactionServiceProvider.future);
      final catService = await _ref.read(categoryServiceProvider.future);

      if (state.isTransfer) {
        final transferCatId = await catService.getTransferCategoryId();
        if (transferCatId == null) {
          return QuickAddError('Transfer category missing. Re-seed categories.');
        }
        final ids = await txnService.addTransferPair(
          fromAccountId: state.accountId!,
          toAccountId: state.toAccountId!,
          amountInPaise: state.amountInPaise,
          transactionDate: state.transactionDate,
          transferCategoryId: transferCatId,
          note: state.note.isEmpty ? null : state.note,
          payee: state.payee.isEmpty ? null : state.payee,
        );
        return QuickAddSuccess(ids.first);
      } else {
        final txn = Transaction()
          ..type = state.type
          ..amountInPaise = state.amountInPaise
          ..categoryId = state.categoryId!
          ..accountId = state.accountId!
          ..transactionDate = state.transactionDate
          ..note = state.note.isEmpty ? null : state.note
          ..payee = state.payee.isEmpty ? null : state.payee
          ..tags = state.tags;
        final id = await txnService.addTransaction(txn);
        return QuickAddSuccess(id);
      }
    } catch (e) {
      return QuickAddError('Failed to save: $e');
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  String _validationMsg() {
    if (!state.hasAmount) return 'Enter an amount';
    if (!state.hasCategory) return 'Select a category';
    if (!state.hasAccount) return 'Select an account';
    if (state.isTransfer && state.toAccountId == null) {
      return 'Select destination account';
    }
    if (state.isTransfer && state.toAccountId == state.accountId) {
      return 'Source and destination must differ';
    }
    return 'Something is missing';
  }
}

final quickAddNotifierProvider =
    StateNotifierProvider.autoDispose<QuickAddNotifier, QuickAddState>((ref) {
  return QuickAddNotifier(ref);
});