// lib/features/home/widgets/account_cards_strip.dart
//
// PaisaPlus – Account Cards Strip
// ---------------------------------
// Horizontally scrollable strip of account balance cards.
// Each card shows: account icon + name + current balance + type chip.
// Tapping a card opens the account detail screen (Phase 3).
//
// Credit cards additionally show: outstanding + available credit bar.
// "Add account" card always appears last in the strip.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/schemas/account.dart';
import '../../../core/isar/services/account_service.dart';
import '../../../shared/theme/app_colors.dart';

class AccountCardsStrip extends ConsumerWidget {
  const AccountCardsStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balancesAsync = ref.watch(allAccountBalancesProvider);
    final isPrivate = ref.watch(privacyModeProvider);

    return SizedBox(
      height: 120,
      child: balancesAsync.when(
        loading: () => _shimmerStrip(),
        error: (_, __) => const SizedBox.shrink(),
        data: (balances) {
          final sortedBalances = balances.values.toList()
            ..sort((a, b) => a.account.sortOrder.compareTo(b.account.sortOrder));

          return ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              ...sortedBalances.map((ab) => _AccountCard(accountBalance: ab, isPrivate: isPrivate)),
              _AddAccountCard(),
            ],
          );
        },
      ),
    );
  }

  Widget _shimmerStrip() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, __) => Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Account Card
// ─────────────────────────────────────────────────────────────────────────────

class _AccountCard extends StatelessWidget {
  final AccountBalance accountBalance;
  final bool isPrivate;

  const _AccountCard({required this.accountBalance, required this.isPrivate});

  @override
  Widget build(BuildContext context) {
    final account = accountBalance.account;
    final balancePaise = accountBalance.balanceInPaise;
    final isCreditCard = account.type == AccountType.creditCard;
    final isNegative = balancePaise < 0;

    final accountColor = Color(account.colorValue);
    final formatter = NumberFormat('#,##,##0', 'en_IN');

    // Balance label logic reserved for Phase 3 account detail view

    return GestureDetector(
      onTap: () {
        // Account detail screen — built in Phase 3.
        // Route: /accounts/:id  (registered in app_router.dart)
        context.push('/accounts/${account.id}');
      },
      child: Container(
        width: 158,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accountColor.withValues(alpha: 0.3),
            width: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon + type ──────────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: accountColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    IconData(account.iconCodePoint,
                        fontFamily: 'MaterialIcons'),
                    size: 16,
                    color: accountColor,
                  ),
                ),
                const Spacer(),
                _AccountTypeChip(type: account.type),
              ],
            ),

            const SizedBox(height: 10),

            // ── Account name ─────────────────────────────────────────────
            Text(
              account.name,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary).copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 2),

            // ── Balance ──────────────────────────────────────────────────
            Text(
              isPrivate ? '••••' : '₹${formatter.format(balancePaise.abs() / 100.0)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isNegative || isCreditCard
                    ? AppColors.primary
                    : AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // ── Credit utilisation bar (credit cards only) ────────────────
            if (isCreditCard && accountBalance.creditUtilisation != null) ...[
              const SizedBox(height: 8),
              _CreditBar(utilisation: accountBalance.creditUtilisation!),
            ],
          ],
        ),
      ),
    );
  }
}

class _AccountTypeChip extends StatelessWidget {
  final AccountType type;

  const _AccountTypeChip({required this.type});

  static const _labels = {
    AccountType.cash: 'Cash',
    AccountType.bankAccount: 'Bank',
    AccountType.creditCard: 'Credit',
    AccountType.digitalWallet: 'UPI',
    AccountType.investment: 'Invest',
    AccountType.loan: 'Loan',
    AccountType.other: 'Other',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _labels[type] ?? 'Other',
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: AppColors.textTertiary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _CreditBar extends StatelessWidget {
  final double utilisation; // 0.0 – 1.0

  const _CreditBar({required this.utilisation});

  @override
  Widget build(BuildContext context) {
    final color = utilisation > 0.8
        ? AppColors.primary
        : utilisation > 0.5
            ? AppColors.warning
            : AppColors.income;

    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: LinearProgressIndicator(
        value: utilisation.clamp(0.0, 1.0),
        backgroundColor: AppColors.border,
        valueColor: AlwaysStoppedAnimation(color),
        minHeight: 3,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Add Account Card
// ─────────────────────────────────────────────────────────────────────────────

class _AddAccountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add account sheet — built in Phase 3.
        // Route: /accounts/add  (registered in app_router.dart)
        context.push('/accounts/add');
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add\nAccount',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary).copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}