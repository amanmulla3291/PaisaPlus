// lib/features/transactions/quick_add/widgets/category_picker.dart
//
// PaisaPlus – Category Picker (QuickAdd sheet)
// ----------------------------------------------
// Scrollable grid of category icon chips shown inside the QuickAdd sheet.
// Tapping a chip selects it (highlights in its own color) and advances focus
// to the account picker row — the next required field.
//
// Search bar at top narrows the grid in real-time via CategoryService.search().
// "New category" chip at the end opens the add-category flow (Phase 3).
//
// Layout: horizontally scrollable row of chips (not a grid) — matching the
// Kite/Zerodha style of compact horizontal scrollable selectors.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/isar/providers/service_providers.dart';
import '../../../../core/isar/schemas/category.dart';
import '../../../../core/isar/schemas/transaction.dart';
import '../../../../shared/theme/app_colors.dart';
import '../quick_add_notifier.dart';

class CategoryPicker extends ConsumerStatefulWidget {
  const CategoryPicker({super.key});

  @override
  ConsumerState<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends ConsumerState<CategoryPicker> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(quickAddNotifierProvider);
    final notifier = ref.read(quickAddNotifierProvider.notifier);
    final catType = state.type == TransactionType.income
        ? CategoryType.income
        : CategoryType.expense;

    // Choose which stream to watch based on type
    final categoriesAsync = state.type == TransactionType.income
        ? ref.watch(watchIncomeCategoriesProvider)
        : ref.watch(watchExpenseCategoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Search bar ────────────────────────────────────────────────────
        SizedBox(
          height: 36,
          child: TextField(
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v.trim()),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Search category…',
              hintStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.textTertiary,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 16,
                color: AppColors.textTertiary,
              ),
              filled: true,
              fillColor: AppColors.surfaceVariant,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: AppColors.primary, width: 1.5),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // ── Category chips ────────────────────────────────────────────────
        categoriesAsync.when(
          loading: () => const SizedBox(
            height: 44,
            child: Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppColors.primary),
            ),
          ),
          error: (_, __) => const SizedBox.shrink(),
          data: (categories) {
            // Apply search filter
            final filtered = _query.isEmpty
                ? categories
                : categories
                    .where((c) => c.name
                        .toLowerCase()
                        .contains(_query.toLowerCase()))
                    .toList();

            return SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  ...filtered.map((cat) => _CategoryChip(
                        category: cat,
                        isSelected: state.categoryId == cat.id,
                        onTap: () {
                          notifier.setCategory(cat.id);
                          // Clear search after selection
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )),
                  // "New" chip — Phase 3 will push /categories/add
                  _NewCategoryChip(type: catType),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Chip
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(category.colorValue);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.18) : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? color : AppColors.border,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconData(category.iconCodePoint, fontFamily: 'MaterialIcons'),
              size: 15,
              color: isSelected ? color : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                color:
                    isSelected ? color : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// New Category Chip — opens add-category flow (Phase 3)
// ─────────────────────────────────────────────────────────────────────────────

class _NewCategoryChip extends StatelessWidget {
  final CategoryType type;
  const _NewCategoryChip({required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add-category sheet — built in Phase 3.
        // context.push('/categories/add?type=${type.name}');
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.4),
            width: 0.5,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, size: 14, color: AppColors.primary),
            SizedBox(width: 4),
            Text(
              'New',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}