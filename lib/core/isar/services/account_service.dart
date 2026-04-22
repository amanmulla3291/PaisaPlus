// lib/core/isar/services/account_service.dart
//
// PaisaPlus – AccountService
// ----------------------------
// All Isar reads/writes for Account + balance calculation.
//
// Isar 3.1.0+1 API rules:
//   • Date filtering → .where().transactionDateBetween() then .filter()
//   • amountInPaise cast → (t.amountInPaise as int)
//   • uuid is hash-indexed → filter().uuidEqualTo()

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/account.dart';
import '../schemas/transaction.dart';
import '../seeds/category_seeds.dart';

const _uuid = Uuid();

class AccountBalance {
  final Account account;
  final int balanceInPaise;

  const AccountBalance({required this.account, required this.balanceInPaise});

  double get balanceInRupees => balanceInPaise / 100.0;

  int? get availableCreditInPaise {
    if (account.type != AccountType.creditCard) return null;
    final limit = account.creditLimitInPaise;
    if (limit == null) return null;
    return limit - balanceInPaise;
  }

  double? get availableCreditInRupees {
    final c = availableCreditInPaise;
    return c != null ? c / 100.0 : null;
  }

  double? get creditUtilisation {
    final limit = account.creditLimitInPaise;
    if (limit == null || limit == 0) return null;
    return balanceInPaise / limit;
  }
}

class AccountService {
  final Isar _isar;
  AccountService(this._isar);

  // ── WRITES ────────────────────────────────────────────────────────────────

  Future<Id> addAccount(Account account) async {
    final now = DateTime.now();
    account
      ..uuid = _uuid.v4()
      ..createdAt = now
      ..updatedAt = now;
    return _isar.writeTxn(() => _isar.accounts.put(account));
  }

  Future<void> updateAccount(Account account) async {
    account.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.accounts.put(account));
  }

  Future<void> archiveAccount(Id id) async {
    final account = await _isar.accounts.get(id);
    if (account == null) return;
    account
      ..isArchived = true
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.accounts.put(account));
  }

  Future<void> unarchiveAccount(Id id) async {
    final account = await _isar.accounts.get(id);
    if (account == null) return;
    account
      ..isArchived = false
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.accounts.put(account));
  }

  Future<void> reorder(List<({Id id, int sortOrder})> updates) async {
    await _isar.writeTxn(() async {
      for (final u in updates) {
        final account = await _isar.accounts.get(u.id);
        if (account != null) {
          account
            ..sortOrder = u.sortOrder
            ..updatedAt = DateTime.now();
          await _isar.accounts.put(account);
        }
      }
    });
  }

  Future<void> seedDefaultAccounts() async {
    final count = await _isar.accounts.count();
    if (count > 0) return;
    final defaults = buildDefaultAccounts();
    await _isar.writeTxn(() => _isar.accounts.putAll(defaults));
  }

  // ── READS ─────────────────────────────────────────────────────────────────

  Future<Account?> getById(Id id) => _isar.accounts.get(id);

  Future<Account?> getByUuid(String uuid) async {
    return _isar.accounts.where().uuidEqualTo(uuid).findFirst();
  }

  Future<List<Account>> getActive() async {
    return _isar.accounts
        .filter()
        .isArchivedEqualTo(false)
        .sortBySortOrder()
        .findAll();
  }

  Future<List<Account>> getAll() async {
    return _isar.accounts.where().anyId().sortBySortOrder().findAll();
  }

  Future<List<Account>> getByType(AccountType type) async {
    return _isar.accounts
        .filter()
        .isArchivedEqualTo(false)
        .and()
        .typeEqualTo(type)
        .sortBySortOrder()
        .findAll();
  }

  // ── BALANCE CALCULATION ───────────────────────────────────────────────────

  Future<AccountBalance> getBalance(Id accountId) async {
    final account = await _isar.accounts.get(accountId);
    if (account == null) throw StateError('Account $accountId not found');

    final sinceDate = account.openingBalanceDate;

    // Use transactionDateBetween for index-based date filtering
    final txns = await _isar.transactions
        .where()
        .transactionDateBetween(sinceDate, DateTime.now())
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .accountIdEqualTo(accountId)
        .findAll();

    final transferCredits = await _isar.transactions
        .where()
        .transactionDateBetween(sinceDate, DateTime.now())
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .toAccountIdEqualTo(accountId)
        .findAll();

    int balance = account.openingBalanceInPaise;

    for (final txn in txns) {
      switch (txn.type) {
        case TransactionType.income:
          balance += txn.amountInPaise;
        case TransactionType.expense:
          balance -= txn.amountInPaise;
        case TransactionType.transfer:
          if (txn.isTransferDebit) balance -= txn.amountInPaise;
      }
    }
    for (final credit in transferCredits) {
      balance += credit.amountInPaise;
    }

    return AccountBalance(account: account, balanceInPaise: balance);
  }

  Future<Map<Id, AccountBalance>> getAllBalances() async {
    final accounts = await getActive();
    final Map<Id, AccountBalance> result = {};

    final allTxns = await _isar.transactions
        .filter()
        .isDeletedEqualTo(false)
        .findAll();

    for (final account in accounts) {
      final sinceDate = account.openingBalanceDate;
      int balance = account.openingBalanceInPaise;

      for (final txn in allTxns) {
        if (txn.transactionDate.isBefore(sinceDate)) continue;

        if (txn.accountId == account.id) {
          switch (txn.type) {
            case TransactionType.income:
              balance += txn.amountInPaise;
            case TransactionType.expense:
              balance -= txn.amountInPaise;
            case TransactionType.transfer:
              if (txn.isTransferDebit) balance -= txn.amountInPaise;
          }
        } else if (txn.toAccountId == account.id) {
          balance += txn.amountInPaise;
        }
      }

      result[account.id] = AccountBalance(account: account, balanceInPaise: balance);
    }
    return result;
  }

  Future<int> getNetWorthInPaise() async {
    final balances = await getAllBalances();
    int netWorth = 0;
    for (final ab in balances.values) {
      if (ab.account.isExcludedFromTotal) continue;
      if (ab.account.type == AccountType.creditCard ||
          ab.account.type == AccountType.loan) {
        netWorth -= ab.balanceInPaise;
      } else {
        netWorth += ab.balanceInPaise;
      }
    }
    return netWorth;
  }

  Future<int> getTotalBalanceInPaise() async {
    final balances = await getAllBalances();
    int total = 0;
    for (final ab in balances.values) {
      if (ab.account.isExcludedFromTotal) continue;
      if (ab.account.type == AccountType.creditCard) continue;
      if (ab.account.type == AccountType.loan) continue;
      if (ab.account.type == AccountType.investment) continue;
      total += ab.balanceInPaise;
    }
    return total;
  }

  // ── WATCH ─────────────────────────────────────────────────────────────────

  Stream<void> watchAll() => _isar.accounts.watchLazy();

  Stream<List<Account>> watchActive() {
    return _isar.accounts
        .filter()
        .isArchivedEqualTo(false)
        .watch(fireImmediately: true);
  }
}