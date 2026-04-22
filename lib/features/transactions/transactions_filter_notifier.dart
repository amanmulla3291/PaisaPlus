// lib/features/transactions/transactions_filter_notifier.dart
// ─────────────────────────────────────────────────────────────────────────────
// Plain StateNotifier — no riverpod_annotation, matches Phase 1 style.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/isar/providers/service_providers.dart';

import '../../core/isar/schemas/transaction.dart';

enum TxnSortOrder { newestFirst, oldestFirst, highestAmount, lowestAmount }

class TxnFilterState {
  final String searchQuery;
  final TransactionType? type;
  final int? categoryId;
  final int? accountId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final TxnSortOrder sortOrder;
  final List<Transaction> transactions;
  final bool isLoading;
  final bool hasMore;
  final int page;

  const TxnFilterState({
    this.searchQuery = '',
    this.type,
    this.categoryId,
    this.accountId,
    this.fromDate,
    this.toDate,
    this.sortOrder = TxnSortOrder.newestFirst,
    this.transactions = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.page = 0,
  });

  bool get hasActiveFilters =>
      type != null ||
      categoryId != null ||
      accountId != null ||
      fromDate != null ||
      toDate != null ||
      searchQuery.isNotEmpty;

  static const _s = Object();

  TxnFilterState copyWith({
    String? searchQuery,
    Object? type = _s,
    Object? categoryId = _s,
    Object? accountId = _s,
    Object? fromDate = _s,
    Object? toDate = _s,
    TxnSortOrder? sortOrder,
    List<Transaction>? transactions,
    bool? isLoading,
    bool? hasMore,
    int? page,
  }) {
    return TxnFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      type: type == _s ? this.type : type as TransactionType?,
      categoryId: categoryId == _s ? this.categoryId : categoryId as int?,
      accountId: accountId == _s ? this.accountId : accountId as int?,
      fromDate: fromDate == _s ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _s ? this.toDate : toDate as DateTime?,
      sortOrder: sortOrder ?? this.sortOrder,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
    );
  }
}

class TxnFilterNotifier extends StateNotifier<TxnFilterState> {
  final Ref _ref;
  static const _pageSize = 30;

  TxnFilterNotifier(this._ref) : super(const TxnFilterState(isLoading: true)) {
    Future.microtask(() => _loadPage(reset: true));
  }

  void setSearch(String q) {
    state = state.copyWith(searchQuery: q);
    _loadPage(reset: true);
  }

  void setType(TransactionType? type) {
    state = state.copyWith(type: type);
    _loadPage(reset: true);
  }

  void setCategoryId(int? id) {
    state = state.copyWith(categoryId: id);
    _loadPage(reset: true);
  }

  void setAccountId(int? id) {
    state = state.copyWith(accountId: id);
    _loadPage(reset: true);
  }

  void setDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(fromDate: from, toDate: to);
    _loadPage(reset: true);
  }

  void setSortOrder(TxnSortOrder order) {
    state = state.copyWith(sortOrder: order);
    _loadPage(reset: true);
  }

  void clearFilters() {
    state = const TxnFilterState(isLoading: true);
    _loadPage(reset: true);
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasMore) return;
    await _loadPage(reset: false);
  }

  Future<void> refresh() async {
    await _loadPage(reset: true);
  }

  Future<void> _loadPage({required bool reset}) async {
    if (state.isLoading && !reset) return;
    final currentPage = reset ? 0 : state.page;
    state = state.copyWith(isLoading: true, page: currentPage);

    try {
      final txnService = await _ref.read(transactionServiceProvider.future);
      final catService = await _ref.read(categoryServiceProvider.future);

      var raw = await txnService.getFiltered(
        fromDate: state.fromDate,
        toDate: state.toDate,
        categoryId: state.categoryId,
        accountId: state.accountId,
        type: state.type,
        offset: currentPage * _pageSize,
        limit: _pageSize,
      );

      raw = _sort(raw, state.sortOrder);

      if (state.searchQuery.isNotEmpty) {
        final q = state.searchQuery.toLowerCase();
        final matched = <Transaction>[];
        for (final txn in raw) {
          if (_matches(txn, q)) {
            matched.add(txn);
            continue;
          }
          final cat = await catService.getById(txn.categoryId);
          if (cat != null && cat.name.toLowerCase().contains(q)) {
            matched.add(txn);
          }
        }
        raw = matched;
      }

      final newList = reset ? raw : [...state.transactions, ...raw];
      state = state.copyWith(
        transactions: newList,
        isLoading: false,
        hasMore: raw.length == _pageSize,
        page: currentPage + 1,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false, hasMore: false);
    }
  }

  bool _matches(Transaction txn, String q) {
    if (txn.payee?.toLowerCase().contains(q) == true) return true;
    if (txn.note?.toLowerCase().contains(q) == true) return true;
    if (txn.tags.any((t) => t.toLowerCase().contains(q))) return true;
    return false;
  }

  List<Transaction> _sort(List<Transaction> list, TxnSortOrder order) {
    final copy = List<Transaction>.from(list);
    switch (order) {
      case TxnSortOrder.newestFirst:
        copy.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
      case TxnSortOrder.oldestFirst:
        copy.sort((a, b) => a.transactionDate.compareTo(b.transactionDate));
      case TxnSortOrder.highestAmount:
        copy.sort((a, b) => b.amountInPaise
            .compareTo(a.amountInPaise));
      case TxnSortOrder.lowestAmount:
        copy.sort((a, b) => a.amountInPaise
            .compareTo(b.amountInPaise));
    }
    return copy;
  }
}

final txnFilterNotifierProvider =
    StateNotifierProvider.autoDispose<TxnFilterNotifier, TxnFilterState>((ref) {
  return TxnFilterNotifier(ref);
});