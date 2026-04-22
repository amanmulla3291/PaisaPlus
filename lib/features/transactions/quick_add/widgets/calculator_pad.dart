// lib/features/transactions/quick_add/widgets/calculator_pad.dart
//
// PaisaPlus – Calculator Pad
// ----------------------------
// The Kite-style number entry pad at the bottom of the QuickAdd sheet.
//
// Layout (4 rows × 3 columns):
//   7   8   9
//   4   5   6
//   1   2   3
//   .   0   ⌫
//
// The decimal key (.) is cosmetic — we store paise (integer) and the
// display always shows 2 decimal places. Tapping '.' has no effect on
// amountString but gives the user familiar calculator UX. The last two
// digits of amountString are always treated as paise.
// Example: "1234" displayed as "12.34", "100" as "1.00", "5" as "0.05"
//
// The backspace key long-press → clears the entire amount (pressAll).
// Each key press triggers HapticFeedback.selectionClick() — handled
// inside QuickAddNotifier so this widget stays presentation-only.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_colors.dart';
import '../quick_add_notifier.dart';

class CalculatorPad extends ConsumerWidget {
  const CalculatorPad({super.key});

  static const _keys = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['.', '0', '⌫'],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(quickAddNotifierProvider.notifier);

    return Column(
      children: _keys.map((row) {
        return Expanded(
          child: Row(
            children: row.map((key) {
              return Expanded(
                child: _CalcKey(
                  label: key,
                  onTap: () => _handleTap(key, notifier),
                  onLongPress: key == '⌫'
                      ? () => notifier.pressClear()
                      : null,
                  isBackspace: key == '⌫',
                  isDecimal: key == '.',
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  void _handleTap(String key, QuickAddNotifier notifier) {
    switch (key) {
      case '⌫':
        notifier.pressBackspace();
      case '.':
        // Cosmetic — decimal is always implied (last 2 digits = paise).
        // No state change; the UX expectation is already met by display format.
        break;
      default:
        notifier.pressDigit(key);
    }
  }
}

class _CalcKey extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool isBackspace;
  final bool isDecimal;

  const _CalcKey({
    required this.label,
    required this.onTap,
    this.onLongPress,
    this.isBackspace = false,
    this.isDecimal = false,
  });

  @override
  State<_CalcKey> createState() => _CalcKeyState();
}

class _CalcKeyState extends State<_CalcKey>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      lowerBound: 0.92,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.reverse(),
      onTapUp: (_) {
        _pressController.forward();
        widget.onTap();
      },
      onTapCancel: () => _pressController.forward(),
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _pressController,
        builder: (_, child) => Transform.scale(
          scale: _pressController.value,
          child: child,
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: widget.isBackspace
                ? AppColors.surfaceVariant
                : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: Center(
            child: widget.isBackspace
                ? const Icon(
                    Icons.backspace_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  )
                : Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.isDecimal ? 22 : 22,
                      fontWeight: FontWeight.w500,
                      color: widget.isDecimal
                          ? AppColors.textTertiary
                          : AppColors.textPrimary,
                      height: 1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}