// lib/features/transactions/transactions_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// Phase 2 Transactions Screen — replaces the "Coming in Phase 2" stub.
// Full paginated list with date-group headers, filters, swipe-to-delete.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/isar/providers/service_providers.dart';
import '../../core/isar/schemas/transaction.dart';
import '../../shared/theme/app_colors.dart';
import 'transactions_filter_notifier.dart';
import 'widgets/transaction_list_tile.dart';
import 'widgets/transactions_filter_bar.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() =>
      _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Refresh list whenever a transaction is written via the FAB
    ref.listenManual(watchRecentTransactionsProvider, (_, __) {
      ref.read(txnFilterNotifierProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 300) {
      ref.read(txnFilterNotifierProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(txnFilterNotifierProvider);
    final groups = _buildGroups(filter.transactions);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        onRefresh: () =>
            ref.read(txnFilterNotifierProvider.notifier).refresh(),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          slivers: [
            // Totals AppBar
            _TotalsBar(filter: filter),

            // Sticky filter bar
            const SliverPersistentHeader(
              pinned: true,
              delegate: _FilterBarDelegate(
                child: TransactionsFilterBar(),
              ),
            ),

            // Body
            if (filter.isLoading && filter.transactions.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
              )
            else if (filter.transactions.isEmpty)
              SliverFillRemaining(
                child: _EmptyState(
                  hasFilters: filter.hasActiveFilters,
                  onClear: () => ref
                      .read(txnFilterNotifierProvider.notifier)
                      .clearFilters(),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final item = groups[i];
                    if (item is _DateHeader) {
                      return _DateGroupHeader(header: item);
                    } else if (item is _TxnItem) {
                      return Column(
                        children: [
                          TransactionListTile(
                            transaction: item.transaction,
                            onDeleted: () => ref
                                .read(txnFilterNotifierProvider.notifier)
                                .refresh(),
                          ),
                          if (!item.isLastInGroup)
                            const Divider(
                              height: 0.5,
                              thickness: 0.5,
                              indent: 68,
                            ),
                        ],
                      );
                    }
                    return null;
                  },
                  childCount: groups.length,
                ),
              ),

            // Footer
            SliverToBoxAdapter(child: _Footer(filter: filter)),
          ],
        ),
      ),
    );
  }

  List<Object> _buildGroups(List<Transaction> transactions) {
    final items = <Object>[];
    DateTime? currentDay;
    final dayTotals = <DateTime, _DayTotals>{};

    for (final txn in transactions) {
      final day = DateTime(txn.transactionDate.year,
          txn.transactionDate.month, txn.transactionDate.day);
      final dt = dayTotals.putIfAbsent(day, () => _DayTotals());
      if (txn.type == TransactionType.expense) {
        dt.expense += txn.amountInPaise;
      }
      if (txn.type == TransactionType.income) {
        dt.income += txn.amountInPaise;
      }
    }

    for (int i = 0; i < transactions.length; i++) {
      final txn = transactions[i];
      final day = DateTime(txn.transactionDate.year,
          txn.transactionDate.month, txn.transactionDate.day);

      if (currentDay == null || day != currentDay) {
        currentDay = day;
        items.add(_DateHeader(date: day, totals: dayTotals[day]!));
      }

      final isLast = i == transactions.length - 1 ||
          DateTime(
                transactions[i + 1].transactionDate.year,
                transactions[i + 1].transactionDate.month,
                transactions[i + 1].transactionDate.day,
              ) !=
              day;

      items.add(_TxnItem(transaction: txn, isLastInGroup: isLast));
    }

    return items;
  }
}

// ── Totals bar ────────────────────────────────────────────────────────────────

class _TotalsBar extends StatelessWidget {
  final TxnFilterState filter;
  const _TotalsBar({required this.filter});

  @override
  Widget build(BuildContext context) {
    int expense = 0, income = 0;
    for (final t in filter.transactions) {
      if (t.type == TransactionType.expense) {
        expense += t.amountInPaise;
      } else if (t.type == TransactionType.income) {
        income += t.amountInPaise;
      }
    }
    final fmt = NumberFormat('#,##,##0', 'en_IN');

    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: const Text(
        'Transactions',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      actions: [
        if (expense > 0)
          _StatBadge(
            label: '−₹${fmt.format(expense / 100)}',
            color: AppColors.expense,
          ),
        if (income > 0) ...[
          const SizedBox(width: 6),
          _StatBadge(
            label: '+₹${fmt.format(income / 100)}',
            color: AppColors.income,
          ),
        ],
        const SizedBox(width: 12),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0.5),
        child: Divider(
            height: 0.5,
            thickness: 0.5,
            color: AppColors.border),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// ── Date group header ─────────────────────────────────────────────────────────

class _DateGroupHeader extends StatelessWidget {
  final _DateHeader header;
  const _DateGroupHeader({required this.header});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final fmt = NumberFormat('#,##,##0', 'en_IN');

    String label;
    if (header.date == today) {
      label = 'Today';
    } else if (header.date == yesterday) {
      label = 'Yesterday';
    } else if (header.date.year == now.year) {
      label = DateFormat('EEEE, d MMMM').format(header.date);
    } else {
      label = DateFormat('EEEE, d MMMM yyyy').format(header.date);
    }

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          if (header.totals.expense > 0)
            Text(
              '−₹${fmt.format(header.totals.expense / 100)}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.expense,
              ),
            ),
          if (header.totals.expense > 0 && header.totals.income > 0)
            const SizedBox(width: 6),
          if (header.totals.income > 0)
            Text(
              '+₹${fmt.format(header.totals.income / 100)}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.income,
              ),
            ),
        ],
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  final TxnFilterState filter;
  const _Footer({required this.filter});

  @override
  Widget build(BuildContext context) {
    if (filter.isLoading && filter.transactions.isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: CircularProgressIndicator(
              strokeWidth: 2, color: AppColors.primary),
        ),
      );
    }
    if (!filter.hasMore && filter.transactions.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Center(
          child: Text(
            'All ${filter.transactions.length} transactions loaded',
            style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: AppColors.textTertiary),
          ),
        ),
      );
    }
    return const SizedBox(height: 100);
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final bool hasFilters;
  final VoidCallback onClear;
  const _EmptyState({required this.hasFilters, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasFilters
                ? Icons.filter_list_off_rounded
                : Icons.receipt_long_outlined,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 14),
          Text(
            hasFilters ? 'No transactions match\nyour filters' : 'No transactions yet',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          if (hasFilters) ...[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  'Clear Filters',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── SliverPersistentHeader delegate ──────────────────────────────────────────

class _FilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  static const _height = 96.0;
  const _FilterBarDelegate({required this.child});

  @override
  double get minExtent => _height;
  @override
  double get maxExtent => _height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: AppColors.background,
      child: Column(
        children: [
          child,
          if (overlapsContent)
            const Divider(height: 0.5, thickness: 0.5),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_FilterBarDelegate old) => old.child != child;
}

// ── Internal data models ──────────────────────────────────────────────────────

class _DayTotals {
  int expense = 0;
  int income = 0;
}

class _DateHeader {
  final DateTime date;
  final _DayTotals totals;
  const _DateHeader({required this.date, required this.totals});
}

class _TxnItem {
  final Transaction transaction;
  final bool isLastInGroup;
  const _TxnItem({required this.transaction, required this.isLastInGroup});
}