// lib/features/home/widgets/balance_card.dart
//
// PaisaPlus – Balance Card
// --------------------------
// The hero widget at the top of the home screen.
// Shows the total liquid balance (cash + bank + digital wallets) in large bold
// text with an animated counter on first load / month change.
//
// Features:
//  • Animated rolling number (TweenAnimationBuilder) on load
//  • Toggle between "Total Balance" and "Net Worth" on tap
//  • Savings rate chip (savings / income × 100)
//  • Month savings = income − expense for selected month
//  • Eye icon to hide amounts (privacy mode)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/schemas/account.dart';
import '../../../core/isar/services/account_service.dart';
import '../../../shared/theme/app_colors.dart';

enum _BalanceMode { totalBalance, netWorth }

class BalanceCard extends ConsumerStatefulWidget {
  final DateTime selectedMonth;

  const BalanceCard({super.key, required this.selectedMonth});

  @override
  ConsumerState<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends ConsumerState<BalanceCard> {
  _BalanceMode _mode = _BalanceMode.totalBalance;
  bool _isHidden = false;

  void _toggleMode() {
    HapticFeedback.selectionClick();
    setState(() {
      _mode = _mode == _BalanceMode.totalBalance
          ? _BalanceMode.netWorth
          : _BalanceMode.totalBalance;
    });
  }

  void _toggleHide() {
    HapticFeedback.selectionClick();
    setState(() => _isHidden = !_isHidden);
  }

  @override
  Widget build(BuildContext context) {
    final totalBalance = ref.watch(allAccountBalancesProvider);
    final netWorth = ref.watch(netWorthInPaiseProvider);
    final monthlyExpense =
        ref.watch(monthlyExpenseInPaiseProvider(widget.selectedMonth));
    final monthlyIncome =
        ref.watch(monthlyIncomeInPaiseProvider(widget.selectedMonth));
    final globalPrivacy = ref.watch(privacyModeProvider);
    final effectivelyHidden = _isHidden || globalPrivacy;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Mode label + toggle ──────────────────────────────────────────
          Row(
            children: [
              GestureDetector(
                onTap: _toggleMode,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _mode == _BalanceMode.totalBalance
                          ? 'Total Balance'
                          : 'Net Worth',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary).copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.swap_horiz_rounded,
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _toggleHide,
                child: Icon(
                  effectivelyHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Hero amount ──────────────────────────────────────────────────
          if (effectivelyHidden)
            const Text(
              '₹ ••••••',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: AppColors.textTertiary,
                letterSpacing: -1,
              ),
            )
          else
            _AmountDisplay(
              mode: _mode,
              totalBalance: totalBalance,
              netWorth: netWorth,
            ),

          const SizedBox(height: 16),

          // ── Month stat row ───────────────────────────────────────────────
          _MonthStatRow(
            monthlyExpense: monthlyExpense,
            monthlyIncome: monthlyIncome,
            isHidden: effectivelyHidden,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Amount Display with animated counter
// ─────────────────────────────────────────────────────────────────────────────

class _AmountDisplay extends StatelessWidget {
  final _BalanceMode mode;
  final AsyncValue<Map<int, AccountBalance>> totalBalance;
  final AsyncValue<int> netWorth;

  const _AmountDisplay({
    required this.mode,
    required this.totalBalance,
    required this.netWorth,
  });

  @override
  Widget build(BuildContext context) {
    if (mode == _BalanceMode.totalBalance) {
      return totalBalance.when(
        loading: () => _shimmerAmount(),
        error: (e, _) => _errorAmount(),
        data: (balances) {
          // Sum non-excluded, non-credit accounts
          int total = 0;
          for (final ab in balances.values) {
            if (ab.account.isExcludedFromTotal) continue;
            if (ab.account.type == AccountType.creditCard) continue;
            if (ab.account.type == AccountType.loan) continue;
            if (ab.account.type == AccountType.investment) continue;
            total += ab.balanceInPaise;
          }
          return _AnimatedAmount(paise: total);
        },
      );
    } else {
      return netWorth.when(
        loading: () => _shimmerAmount(),
        error: (e, _) => _errorAmount(),
        data: (paise) => _AnimatedAmount(paise: paise),
      );
    }
  }

  Widget _shimmerAmount() {
    return Container(
      width: 180,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _errorAmount() {
    return const Text(
      '₹ —',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -1.5, height: 1.0),
    );
  }
}

class _AnimatedAmount extends StatelessWidget {
  final int paise;

  const _AnimatedAmount({required this.paise});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    final isNegative = paise < 0;
    final absRupees = paise.abs() / 100.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: absRupees),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (_, value, __) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ₹ symbol
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                '₹',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Text(
              '${isNegative ? '-' : ''}${formatter.format(value)}',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -1.5, height: 1.0).copyWith(
                color: isNegative
                    ? AppColors.primary
                    : AppColors.textPrimary,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Month Stat Row — expense | income | savings rate
// ─────────────────────────────────────────────────────────────────────────────

class _MonthStatRow extends StatelessWidget {
  final AsyncValue<int> monthlyExpense;
  final AsyncValue<int> monthlyIncome;
  final bool isHidden;

  const _MonthStatRow({
    required this.monthlyExpense,
    required this.monthlyIncome,
    required this.isHidden,
  });

  @override
  Widget build(BuildContext context) {
    return monthlyIncome.when(
      loading: () => const SizedBox(height: 36),
      error: (_, __) => const SizedBox.shrink(),
      data: (incomeP) => monthlyExpense.when(
        loading: () => const SizedBox(height: 36),
        error: (_, __) => const SizedBox.shrink(),
        data: (expenseP) {
          final savings = incomeP - expenseP;
          final savingsRate =
              incomeP > 0 ? (savings / incomeP * 100).clamp(0, 100) : 0.0;

          return Row(
            children: [
              _StatChip(
                label: 'Spent',
                value: expenseP,
                color: AppColors.primary,
                isHidden: isHidden,
              ),
              const SizedBox(width: 8),
              _StatChip(
                label: 'Earned',
                value: incomeP,
                color: AppColors.income,
                isHidden: isHidden,
              ),
              const SizedBox(width: 8),
              _SavingsRateChip(rate: savingsRate.toDouble()),
            ],
          );
        },
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final bool isHidden;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
    required this.isHidden,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##,##0', 'en_IN');
    final rupees = value / 100.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.15), width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary)),
            const SizedBox(height: 2),
            Text(
              isHidden ? '••••' : '₹${formatter.format(rupees)}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: -0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _SavingsRateChip extends StatelessWidget {
  final double rate;

  const _SavingsRateChip({required this.rate});

  @override
  Widget build(BuildContext context) {
    final isGood = rate >= 20;
    final color = isGood ? AppColors.income : AppColors.warning;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.15), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Saved', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary)),
          const SizedBox(height: 2),
          Text(
            '${rate.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}