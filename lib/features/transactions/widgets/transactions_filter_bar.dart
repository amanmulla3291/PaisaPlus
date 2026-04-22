// lib/features/transactions/widgets/transactions_filter_bar.dart
//
// PaisaPlus – Transactions Filter Bar
// --------------------------------------
// The sticky filter strip below the AppBar on the Transactions screen.
// Two visual rows:
//
//   Row 1: [🔍 Search field ─────────────────────] [Sort ↕]
//   Row 2: [All] [Expense] [Income] [Transfer] [📅 Date] [Category ▾] [Account ▾]
//
// Each filter chip is a toggle — tapping it again clears that filter.
// "Clear all" appears as a chip when hasActiveFilters == true.
//
// The bar is wrapped in a SliverPersistentHeader so it sticks at the top
// while the list scrolls beneath it. Height is fixed at 96dp (two rows).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/schemas/account.dart';
import '../../../core/isar/schemas/category.dart';
import '../../../core/isar/schemas/transaction.dart';
import '../../../shared/theme/app_colors.dart';
import '../transactions_filter_notifier.dart';

class TransactionsFilterBar extends ConsumerStatefulWidget {
  const TransactionsFilterBar({super.key});

  @override
  ConsumerState<TransactionsFilterBar> createState() =>
      _TransactionsFilterBarState();
}

class _TransactionsFilterBarState
    extends ConsumerState<TransactionsFilterBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(txnFilterNotifierProvider);
    final notifier = ref.read(txnFilterNotifierProvider.notifier);

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Row 1: Search + Sort ────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: TextField(
                    controller: _searchController,
                    onChanged: notifier.setSearch,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search payee, note, tag…',
                      hintStyle: const TextStyle(
                          fontSize: 13, color: AppColors.textTertiary),
                      prefixIcon: const Icon(Icons.search_rounded,
                          size: 17, color: AppColors.textTertiary),
                      suffixIcon: filter.searchQuery.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                notifier.setSearch('');
                              },
                              child: const Icon(Icons.clear_rounded,
                                  size: 16,
                                  color: AppColors.textTertiary),
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.surface,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _SortButton(
                current: filter.sortOrder,
                onSelect: notifier.setSortOrder,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Row 2: Type chips + Date + Category + Account + Clear ────────
          SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                // Type chips
                _TypeChip(
                  label: 'All',
                  isSelected: filter.type == null,
                  onTap: () => notifier.setType(null),
                ),
                _TypeChip(
                  label: 'Expense',
                  icon: Icons.arrow_downward_rounded,
                  color: AppColors.primary,
                  isSelected: filter.type == TransactionType.expense,
                  onTap: () => notifier.setType(
                    filter.type == TransactionType.expense
                        ? null
                        : TransactionType.expense,
                  ),
                ),
                _TypeChip(
                  label: 'Income',
                  icon: Icons.arrow_upward_rounded,
                  color: AppColors.income,
                  isSelected: filter.type == TransactionType.income,
                  onTap: () => notifier.setType(
                    filter.type == TransactionType.income
                        ? null
                        : TransactionType.income,
                  ),
                ),
                _TypeChip(
                  label: 'Transfer',
                  icon: Icons.swap_horiz_rounded,
                  color: AppColors.textSecondary,
                  isSelected: filter.type == TransactionType.transfer,
                  onTap: () => notifier.setType(
                    filter.type == TransactionType.transfer
                        ? null
                        : TransactionType.transfer,
                  ),
                ),

                const SizedBox(width: 4),

                // Date range chip
                _DateRangeChip(filter: filter, notifier: notifier),

                const SizedBox(width: 6),

                // Category filter chip
                _CategoryFilterChip(filter: filter, notifier: notifier),

                const SizedBox(width: 6),

                // Account filter chip
                _AccountFilterChip(filter: filter, notifier: notifier),

                // Clear all chip — appears when any filter is active
                if (filter.hasActiveFilters) ...[
                  const SizedBox(width: 6),
                  _ClearChip(
                    onTap: () {
                      _searchController.clear();
                      notifier.clearFilters();
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sort button
// ─────────────────────────────────────────────────────────────────────────────

class _SortButton extends StatelessWidget {
  final TxnSortOrder current;
  final void Function(TxnSortOrder) onSelect;

  const _SortButton({required this.current, required this.onSelect});

  static const _labels = {
    TxnSortOrder.newestFirst: 'Newest',
    TxnSortOrder.oldestFirst: 'Oldest',
    TxnSortOrder.highestAmount: 'Highest',
    TxnSortOrder.lowestAmount: 'Lowest',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSortPicker(context),
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.sort_rounded,
                size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              _labels[current] ?? 'Sort',
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Text('Sort By',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            ...TxnSortOrder.values.map((order) => ListTile(
                  title: Text(_labels[order] ?? ''),
                  trailing: current == order
                      ? const Icon(Icons.check_rounded,
                          color: AppColors.primary, size: 18)
                      : null,
                  onTap: () {
                    onSelect(order);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filter chips
// ─────────────────────────────────────────────────────────────────────────────

class _TypeChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    this.icon,
    this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? c.withValues(alpha: 0.14) : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? c.withValues(alpha: 0.5) : AppColors.border,
            width: isSelected ? 1.2 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon!, size: 11, color: isSelected ? c : AppColors.textTertiary),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? c : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateRangeChip extends ConsumerWidget {
  final TxnFilterState filter;
  final TxnFilterNotifier notifier;

  const _DateRangeChip({required this.filter, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDate = filter.fromDate != null || filter.toDate != null;
    final label = hasDate
        ? '${DateFormat('d MMM').format(filter.fromDate!)} – ${DateFormat('d MMM').format(filter.toDate!)}'
        : 'Date';

    return GestureDetector(
      onTap: () => _pickDateRange(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: hasDate
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasDate
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.border,
            width: hasDate ? 1.2 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 11,
                color: hasDate
                    ? AppColors.primary
                    : AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    hasDate ? FontWeight.w600 : FontWeight.w400,
                color: hasDate
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: filter.fromDate != null
          ? DateTimeRange(start: filter.fromDate!, end: filter.toDate ?? now)
          : null,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            surface: AppColors.surfaceVariant,
            onSurface: AppColors.textPrimary,
          ),
          dialogTheme: const DialogThemeData(backgroundColor: AppColors.surface),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      notifier.setDateRange(picked.start, picked.end);
    }
  }
}

class _CategoryFilterChip extends ConsumerWidget {
  final TxnFilterState filter;
  final TxnFilterNotifier notifier;

  const _CategoryFilterChip(
      {required this.filter, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasFilter = filter.categoryId != null;
    return GestureDetector(
      onTap: () => _showCategoryPicker(context, ref),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: hasFilter
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasFilter
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.border,
            width: hasFilter ? 1.2 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.category_outlined,
                size: 11,
                color: hasFilter
                    ? AppColors.primary
                    : AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              hasFilter ? 'Category ✓' : 'Category',
              style: TextStyle(
                fontSize: 12,
                fontWeight: hasFilter ? FontWeight.w600 : FontWeight.w400,
                color: hasFilter
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryPicker(BuildContext context, WidgetRef ref) {
    final catAsync = ref.read(watchExpenseCategoriesProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ListPickerSheet<Category>(
        title: 'Filter by Category',
        items: catAsync.valueOrNull ?? [],
        selectedId: filter.categoryId,
        idOf: (c) => c.id,
        labelOf: (c) => c.name,
        iconOf: (c) => IconData(c.iconCodePoint, fontFamily: 'MaterialIcons'),
        colorOf: (c) => Color(c.colorValue),
        onSelect: (id) => notifier.setCategoryId(id),
        onClear: () => notifier.setCategoryId(null),
      ),
    );
  }
}

class _AccountFilterChip extends ConsumerWidget {
  final TxnFilterState filter;
  final TxnFilterNotifier notifier;

  const _AccountFilterChip({required this.filter, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasFilter = filter.accountId != null;
    return GestureDetector(
      onTap: () => _showAccountPicker(context, ref),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: hasFilter
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasFilter
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.border,
            width: hasFilter ? 1.2 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet_outlined,
                size: 11,
                color: hasFilter
                    ? AppColors.primary
                    : AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              hasFilter ? 'Account ✓' : 'Account',
              style: TextStyle(
                fontSize: 12,
                fontWeight: hasFilter ? FontWeight.w600 : FontWeight.w400,
                color: hasFilter
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountPicker(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.read(watchActiveAccountsProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ListPickerSheet<Account>(
        title: 'Filter by Account',
        items: accountsAsync.valueOrNull ?? [],
        selectedId: filter.accountId,
        idOf: (a) => a.id,
        labelOf: (a) => a.name,
        iconOf: (a) =>
            IconData(a.iconCodePoint, fontFamily: 'MaterialIcons'),
        colorOf: (a) => Color(a.colorValue),
        onSelect: (id) => notifier.setAccountId(id),
        onClear: () => notifier.setAccountId(null),
      ),
    );
  }
}

class _ClearChip extends StatelessWidget {
  final VoidCallback onTap;
  const _ClearChip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close_rounded, size: 11, color: AppColors.textTertiary),
            SizedBox(width: 4),
            Text(
              'Clear',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Generic list picker sheet (used for category + account)
// ─────────────────────────────────────────────────────────────────────────────

class _ListPickerSheet<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final int? selectedId;
  final int Function(T) idOf;
  final String Function(T) labelOf;
  final IconData Function(T) iconOf;
  final Color Function(T) colorOf;
  final void Function(int) onSelect;
  final VoidCallback onClear;

  const _ListPickerSheet({
    required this.title,
    required this.items,
    required this.selectedId,
    required this.idOf,
    required this.labelOf,
    required this.iconOf,
    required this.colorOf,
    required this.onSelect,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                const Spacer(),
                if (selectedId != null)
                  GestureDetector(
                    onTap: () {
                      onClear();
                      Navigator.pop(context);
                    },
                    child: const Text('Clear',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.primary)),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];
                final id = idOf(item);
                final color = colorOf(item);
                final isSelected = selectedId == id;

                return ListTile(
                  leading: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(iconOf(item), size: 17, color: color),
                  ),
                  title: Text(labelOf(item),
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.textPrimary)),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded,
                          color: AppColors.primary, size: 18)
                      : null,
                  onTap: () {
                    onSelect(id);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}