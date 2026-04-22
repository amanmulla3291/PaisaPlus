// lib/features/transactions/quick_add/quick_add_sheet.dart
//
// PaisaPlus – QuickAdd Bottom Sheet
// ------------------------------------
// The primary transaction entry surface. Opens from the red FAB and from the
// empty-state "Add Expense" button on the home screen.
//
// Sheet anatomy (top → bottom):
//   ┌──────────────────────────────────────────┐
//   │  ● ── drag handle                         │
//   │  [Expense] [Income] [Transfer]  type tabs │
//   │                                           │
//   │  ₹  1 , 2 3 4 . 5 6     ← amount display │
//   │  [Food] [Groceries] [UPI] …  category row │
//   │  [HDFC] [Today] [Note] [Payee]  meta row  │
//   │───────────────────────────────────────────│
//   │   7    8    9                             │
//   │   4    5    6                             │
//   │   1    2    3          calculator pad     │
//   │   .    0    ⌫                             │
//   │                                           │
//   │  [────────── Add Expense ──────────────]  │
//   └──────────────────────────────────────────┘
//
// The sheet is a DraggableScrollableSheet — user can drag it up for more
// vertical space (useful when the keyboard isn't open).
//
// After a successful save: shows a brief green checkmark animation,
// calls notifier.reset() (preserves type + account), and stays open
// so the user can immediately add another transaction — matching the
// Kite rapid-entry UX.
//
// Opened via: showQuickAddSheet(context) — a standalone function so any
// widget (FAB, empty state button, etc.) can trigger it identically.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/isar/schemas/transaction.dart';
import '../../../shared/theme/app_colors.dart';
import 'quick_add_notifier.dart';
import 'widgets/calculator_pad.dart';
import 'widgets/category_picker.dart';
import 'widgets/quick_add_meta_row.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Public entry point — call this from FAB onPressed and any other trigger
// ─────────────────────────────────────────────────────────────────────────────

Future<void> showQuickAddSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    // ProviderScope override ensures a fresh QuickAddNotifier instance
    // each time the sheet opens (autoDispose handles cleanup on close).
    builder: (ctx) => const ProviderScope(
      overrides: [],
      child: QuickAddSheet(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Sheet widget
// ─────────────────────────────────────────────────────────────────────────────

class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({super.key});

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet>
    with SingleTickerProviderStateMixin {
  // Success flash animation
  late AnimationController _successController;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _successController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final notifier = ref.read(quickAddNotifierProvider.notifier);
    // save() fetches services internally via _ref — no params needed
    final result = await notifier.save();

    if (!mounted) return;

    switch (result) {
      case QuickAddSuccess():
        HapticFeedback.lightImpact();
        // Show success flash
        setState(() => _showSuccess = true);
        await _successController.forward();
        await Future.delayed(const Duration(milliseconds: 300));
        if (!mounted) return;
        _successController.reset();
        setState(() => _showSuccess = false);
        // Reset state but keep sheet open for rapid entry
        notifier.reset();

      case QuickAddError(:final message):
        HapticFeedback.vibrate();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(quickAddNotifierProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: bottomInset),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: Container(
        // Sheet height: 78% of screen when keyboard is closed
        height: MediaQuery.of(context).size.height * 0.78,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // ── Drag handle ──────────────────────────────────────────────
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Type tabs ────────────────────────────────────────────────
            _TypeTabBar(
              selected: state.type,
              onSelect: ref.read(quickAddNotifierProvider.notifier).setType,
            ),

            const SizedBox(height: 16),

            // ── Amount display ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _AmountDisplay(state: state, showSuccess: _showSuccess),
            ),

            const SizedBox(height: 14),

            // ── Category picker ──────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CategoryPicker(),
            ),

            const SizedBox(height: 10),

            // ── Meta row (account / date / note / payee) ─────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: QuickAddMetaRow(),
            ),

            const SizedBox(height: 12),

            // ── Divider ──────────────────────────────────────────────────
            const Divider(height: 0.5, thickness: 0.5),

            // ── Calculator pad ───────────────────────────────────────────
            const Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: CalculatorPad(),
              ),
            ),

            // ── Confirm button ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: _ConfirmButton(
                state: state,
                onTap: state.isSaving ? null : _handleSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Type Tab Bar — Expense / Income / Transfer
// ─────────────────────────────────────────────────────────────────────────────

class _TypeTabBar extends StatelessWidget {
  final TransactionType selected;
  final void Function(TransactionType) onSelect;

  const _TypeTabBar({required this.selected, required this.onSelect});

  static const _tabs = [
    (TransactionType.expense, 'Expense', Icons.arrow_downward_rounded),
    (TransactionType.income, 'Income', Icons.arrow_upward_rounded),
    (TransactionType.transfer, 'Transfer', Icons.swap_horiz_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: _tabs.map((tab) {
            final (type, label, icon) = tab;
            final isSelected = selected == type;
            final color = type == TransactionType.expense
                ? AppColors.primary
                : type == TransactionType.income
                    ? AppColors.income
                    : AppColors.textSecondary;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onSelect(type);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    border: isSelected
                        ? Border.all(color: color.withValues(alpha: 0.4), width: 0.8)
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 13,
                        color: isSelected ? color : AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isSelected ? color : AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Amount Display — the large rupee number above the calculator
// ─────────────────────────────────────────────────────────────────────────────

class _AmountDisplay extends StatelessWidget {
  final QuickAddState state;
  final bool showSuccess;

  const _AmountDisplay({required this.state, required this.showSuccess});

  @override
  Widget build(BuildContext context) {
    final typeColor = state.type == TransactionType.expense
        ? AppColors.primary
        : state.type == TransactionType.income
            ? AppColors.income
            : AppColors.textSecondary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ₹ symbol
        const Text(
          '₹',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(width: 4),

        // Amount — scales font size when number gets long
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: Text(
              state.amountString.isEmpty ? '0' : state.displayAmount,
              key: ValueKey(state.displayAmount),
              style: TextStyle(
                fontSize: _fontSizeForLength(state.displayAmount.length),
                fontWeight: FontWeight.w800,
                color: state.hasAmount ? typeColor : AppColors.textTertiary,
                letterSpacing: -1.5,
                height: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        // Success flash checkmark
        if (showSuccess)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.income.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.income,
              size: 20,
            ),
          ),
      ],
    );
  }

  double _fontSizeForLength(int len) {
    if (len <= 6) return 44;
    if (len <= 9) return 36;
    return 28;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Confirm Button
// ─────────────────────────────────────────────────────────────────────────────

class _ConfirmButton extends StatelessWidget {
  final QuickAddState state;
  final VoidCallback? onTap;

  const _ConfirmButton({required this.state, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final canSave = state.canSave && !state.isSaving;

    final label = switch (state.type) {
      TransactionType.expense => 'Add Expense',
      TransactionType.income => 'Add Income',
      TransactionType.transfer => 'Record Transfer',
    };

    final buttonColor = switch (state.type) {
      TransactionType.expense => AppColors.primary,
      TransactionType.income => AppColors.income,
      TransactionType.transfer => AppColors.textSecondary,
    };

    return AnimatedOpacity(
      opacity: canSave ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: canSave ? buttonColor : buttonColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: state.isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (state.hasAmount) ...[
                        const SizedBox(width: 8),
                        Text(
                          '₹${state.displayAmount}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}