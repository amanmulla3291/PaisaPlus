// lib/core/isar/services/transaction_service.dart
//
// PaisaPlus – TransactionService
// --------------------------------
// All Isar reads/writes for Transaction.
//
// Isar 3.1.0+1 API rules enforced here:
//   • Date filtering → .where().transactionDateBetween() then .filter() chain
//   • String index lookups (uuid, transferPairId) → .filter() property filter
//     (hash-indexed strings use FilterCondition, not WhereClause)
//   • amountInPaise is deserialized as num by Isar → cast with (n as int)
//   • No include: parameter on date where methods in this version

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/transaction.dart';

const _uuid = Uuid();

class TransactionService {
  final Isar _isar;
  TransactionService(this._isar);

  // ── WRITES ────────────────────────────────────────────────────────────────

  Future<Id> addTransaction(Transaction txn) async {
    assert(txn.type != TransactionType.transfer,
        'Use addTransferPair() for transfers');
    _assertValid(txn);
    final now = DateTime.now();
    txn
      ..uuid = _uuid.v4()
      ..createdAt = now
      ..updatedAt = now
      ..isDeleted = false;
    return _isar.writeTxn(() => _isar.transactions.put(txn));
  }

  Future<List<Id>> addTransferPair({
    required int fromAccountId,
    required int toAccountId,
    required int amountInPaise,
    required DateTime transactionDate,
    required int transferCategoryId,
    String? note,
    String? payee,
  }) async {
    assert(fromAccountId != toAccountId);
    assert(amountInPaise > 0);
    final now = DateTime.now();
    final pairId = _uuid.v4();

    final debit = Transaction()
      ..uuid = _uuid.v4()
      ..type = TransactionType.transfer
      ..amountInPaise = amountInPaise
      ..categoryId = transferCategoryId
      ..accountId = fromAccountId
      ..toAccountId = toAccountId
      ..transferPairId = pairId
      ..transactionDate = transactionDate
      ..note = note
      ..payee = payee
      ..entryMode = TransactionEntryMode.manual
      ..isDeleted = false
      ..createdAt = now
      ..updatedAt = now;

    final credit = Transaction()
      ..uuid = _uuid.v4()
      ..type = TransactionType.transfer
      ..amountInPaise = amountInPaise
      ..categoryId = transferCategoryId
      ..accountId = toAccountId
      ..toAccountId = null
      ..transferPairId = pairId
      ..transactionDate = transactionDate
      ..note = note
      ..payee = payee
      ..entryMode = TransactionEntryMode.manual
      ..isDeleted = false
      ..createdAt = now
      ..updatedAt = now;

    return _isar.writeTxn(() async {
      final debitId = await _isar.transactions.put(debit);
      final creditId = await _isar.transactions.put(credit);
      return [debitId, creditId];
    });
  }

  Future<void> updateTransaction(Transaction txn) async {
    assert(txn.type != TransactionType.transfer);
    _assertValid(txn);
    txn.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.transactions.put(txn));
  }

  Future<void> updateTransferPair({
    required Transaction debitLeg,
    required int newAmountInPaise,
    required DateTime newTransactionDate,
    String? newNote,
    String? newPayee,
  }) async {
    assert(debitLeg.transferPairId != null);
    assert(debitLeg.isTransferDebit);

    // transferPairId is a hash-indexed string → use filter()
    final creditLeg = await _isar.transactions
        .filter()
        .transferPairIdEqualTo(debitLeg.transferPairId)
        .and()
        .toAccountIdIsNull()
        .findFirst();

    if (creditLeg == null) throw StateError('Credit leg missing');

    final now = DateTime.now();
    debitLeg
      ..amountInPaise = newAmountInPaise
      ..transactionDate = newTransactionDate
      ..note = newNote
      ..payee = newPayee
      ..updatedAt = now;
    creditLeg
      ..amountInPaise = newAmountInPaise
      ..transactionDate = newTransactionDate
      ..note = newNote
      ..payee = newPayee
      ..updatedAt = now;

    await _isar.writeTxn(() => _isar.transactions.putAll([debitLeg, creditLeg]));
  }

  Future<void> softDelete(Id id) async {
    final txn = await _isar.transactions.get(id);
    if (txn == null) return;
    assert(txn.type != TransactionType.transfer,
        'Use softDeleteTransferPair() for transfers');
    txn
      ..isDeleted = true
      ..deletedAt = DateTime.now()
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.transactions.put(txn));
  }

  Future<void> softDeleteTransferPair(String transferPairId) async {
    // transferPairId is hash-indexed → filter()
    final pair = await _isar.transactions
        .filter()
        .transferPairIdEqualTo(transferPairId)
        .findAll();
    if (pair.isEmpty) return;
    final now = DateTime.now();
    for (final leg in pair) {
      leg
        ..isDeleted = true
        ..deletedAt = now
        ..updatedAt = now;
    }
    await _isar.writeTxn(() => _isar.transactions.putAll(pair));
  }

  Future<void> restore(Id id) async {
    final txn = await _isar.transactions.get(id);
    if (txn == null || !txn.isDeleted) return;
    txn
      ..isDeleted = false
      ..deletedAt = null
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.transactions.put(txn));
  }

  Future<void> hardDelete(Id id) async {
    await _isar.writeTxn(() => _isar.transactions.delete(id));
  }

  Future<int> purgeOldDeleted({Duration olderThan = const Duration(days: 30)}) async {
    final cutoff = DateTime.now().subtract(olderThan);
    final toDelete = await _isar.transactions.filter().isDeletedEqualTo(true).findAll();
    final expiredIds = toDelete
        .where((t) => t.deletedAt != null && t.deletedAt!.isBefore(cutoff))
        .map((t) => t.id)
        .toList();
    if (expiredIds.isEmpty) return 0;
    await _isar.writeTxn(() => _isar.transactions.deleteAll(expiredIds));
    return expiredIds.length;
  }

  // ── READS – paginated ─────────────────────────────────────────────────────

  Future<List<Transaction>> getPage({int offset = 0, int limit = 30}) async {
    return _isar.transactions
        .filter()
        .isDeletedEqualTo(false)
        .sortByTransactionDateDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  Future<List<Transaction>> getPageForAccount({
    required int accountId,
    int offset = 0,
    int limit = 30,
  }) async {
    return _isar.transactions
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .accountIdEqualTo(accountId)
        .sortByTransactionDateDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  Future<List<Transaction>> getPageForCategory({
    required int categoryId,
    int offset = 0,
    int limit = 30,
  }) async {
    return _isar.transactions
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .categoryIdEqualTo(categoryId)
        .sortByTransactionDateDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  Future<List<Transaction>> getPageByType({
    required TransactionType type,
    int offset = 0,
    int limit = 30,
  }) async {
    return _isar.transactions
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .typeEqualTo(type)
        .sortByTransactionDateDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  /// Advanced filter. Date filtering uses where().transactionDateBetween()
  /// for index performance, then additional filter() for other conditions.
  Future<List<Transaction>> getFiltered({
    DateTime? fromDate,
    DateTime? toDate,
    int? categoryId,
    int? accountId,
    TransactionType? type,
    int offset = 0,
    int limit = 30,
  }) async {
    // Fetch with date index if dates provided, otherwise plain filter
    List<Transaction> txns;

    if (fromDate != null && toDate != null) {
      txns = await _isar.transactions
          .where()
          .transactionDateBetween(fromDate, toDate)
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
    } else if (fromDate != null) {
      txns = await _isar.transactions
          .where()
          .transactionDateGreaterThan(fromDate)
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
    } else if (toDate != null) {
      txns = await _isar.transactions
          .where()
          .transactionDateLessThan(toDate)
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
    } else {
      txns = await _isar.transactions
          .filter()
          .isDeletedEqualTo(false)
          .sortByTransactionDateDesc()
          .offset(offset)
          .limit(limit)
          .findAll();
      return txns;
    }

    // Client-side filter for remaining conditions (dataset is already date-scoped)
    if (type != null) txns = txns.where((t) => t.type == type).toList();
    if (categoryId != null) txns = txns.where((t) => t.categoryId == categoryId).toList();
    if (accountId != null) txns = txns.where((t) => t.accountId == accountId).toList();

    txns.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
    final start = offset;
    final end = (offset + limit).clamp(0, txns.length);
    return start >= txns.length ? [] : txns.sublist(start, end);
  }

  // ── READS – date-range aggregates ─────────────────────────────────────────

  Future<List<Transaction>> getForDateRange({
    required DateTime from,
    required DateTime to,
    bool excludeTransfers = false,
  }) async {
    var txns = await _isar.transactions
        .where()
        .transactionDateBetween(from, to)
        .filter()
        .isDeletedEqualTo(false)
        .findAll();

    if (excludeTransfers) {
      txns = txns.where((t) => t.type != TransactionType.transfer).toList();
    }
    txns.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
    return txns;
  }

  Future<int> getTotalExpenseInPaise({
    required DateTime from,
    required DateTime to,
    int? categoryId,
    int? accountId,
  }) async {
    var txns = await _isar.transactions
        .where()
        .transactionDateBetween(from, to)
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .typeEqualTo(TransactionType.expense)
        .findAll();

    if (categoryId != null) txns = txns.where((t) => t.categoryId == categoryId).toList();
    if (accountId != null) txns = txns.where((t) => t.accountId == accountId).toList();

    return txns.fold<int>(0, (sum, t) => sum + t.amountInPaise);
  }

  Future<int> getTotalIncomeInPaise({
    required DateTime from,
    required DateTime to,
    int? accountId,
  }) async {
    var txns = await _isar.transactions
        .where()
        .transactionDateBetween(from, to)
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .typeEqualTo(TransactionType.income)
        .findAll();

    if (accountId != null) txns = txns.where((t) => t.accountId == accountId).toList();
    return txns.fold<int>(0, (sum, t) => sum + t.amountInPaise);
  }

  Future<Map<int, int>> getExpensesByCategoryInPaise({
    required DateTime from,
    required DateTime to,
  }) async {
    final txns = await _isar.transactions
        .where()
        .transactionDateBetween(from, to)
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .typeEqualTo(TransactionType.expense)
        .findAll();

    final Map<int, int> result = {};
    for (final t in txns) {
      result[t.categoryId] = (result[t.categoryId] ?? 0) + t.amountInPaise;
    }
    return result;
  }

  Future<Map<DateTime, int>> getDailyExpenseTotals({
    required DateTime from,
    required DateTime to,
  }) async {
    final txns = await _isar.transactions
        .where()
        .transactionDateBetween(from, to)
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .typeEqualTo(TransactionType.expense)
        .findAll();

    final Map<DateTime, int> result = {};
    for (final t in txns) {
      final dayKey = DateTime(
        t.transactionDate.year,
        t.transactionDate.month,
        t.transactionDate.day,
      );
      result[dayKey] = (result[dayKey] ?? 0) + t.amountInPaise;
    }
    return result;
  }

  Future<Map<DateTime, int>> getDailyIncomeTotals({
    required DateTime from,
    required DateTime to,
  }) async {
    final txns = await _isar.transactions
        .where()
        .transactionDateBetween(from, to)
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .typeEqualTo(TransactionType.income)
        .findAll();

    final Map<DateTime, int> result = {};
    for (final t in txns) {
      final dayKey = DateTime(
        t.transactionDate.year,
        t.transactionDate.month,
        t.transactionDate.day,
      );
      result[dayKey] = (result[dayKey] ?? 0) + t.amountInPaise;
    }
    return result;
  }

  // ── READS – single record ─────────────────────────────────────────────────

  Future<Transaction?> getById(Id id) => _isar.transactions.get(id);

  Future<Transaction?> getByUuid(String uuid) async {
    // uuid is hash-indexed → filter()
    return _isar.transactions.where().uuidEqualTo(uuid).findFirst();
  }

  Future<List<Transaction>> getTransferPair(String transferPairId) async {
    // transferPairId is hash-indexed → filter()
    return _isar.transactions
        .filter()
        .transferPairIdEqualTo(transferPairId)
        .findAll();
  }

  Future<List<Transaction>> getDeleted() async {
    return _isar.transactions
        .filter()
        .isDeletedEqualTo(true)
        .sortByTransactionDateDesc()
        .findAll();
  }

  Future<int> countAll({bool includeDeleted = false}) async {
    if (includeDeleted) return _isar.transactions.count();
    return _isar.transactions.filter().isDeletedEqualTo(false).count();
  }

  // ── WATCH ─────────────────────────────────────────────────────────────────

  Stream<void> watchAll() => _isar.transactions.watchLazy();

  Stream<List<Transaction>> watchForAccount(int accountId) {
    return _isar.transactions
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .accountIdEqualTo(accountId)
        .watch(fireImmediately: true);
  }

  void _assertValid(Transaction txn) {
    assert(txn.amountInPaise > 0, 'Amount must be > 0');
    assert(txn.categoryId > 0, 'categoryId must be set');
    assert(txn.accountId > 0, 'accountId must be set');
  }
}