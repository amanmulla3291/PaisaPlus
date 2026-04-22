// lib/features/accounts/account_detail_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// Screen showing balance trend + full transaction history for a specific account.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/schemas/account.dart';
import '../../../core/isar/schemas/transaction.dart';
import '../../../shared/theme/app_colors.dart';
import 'widgets/account_form_sheet.dart';

class AccountDetailScreen extends ConsumerWidget {
  final int accountId;

  const AccountDetailScreen({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountAsync = ref.watch(accountBalanceProvider(accountId));
    final txnsAsync = ref.watch(watchAccountTransactionsProvider(accountId));
    final isPrivate = ref.watch(privacyModeProvider);

    return accountAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (ab) {
        final account = ab.account;
        final accountColor = Color(account.colorValue);

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              // ── AppBar ───────────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                stretch: true,
                backgroundColor: AppColors.background,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                    onPressed: () => _showEditSheet(context, account),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    account.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  background: Container(
                    padding: const EdgeInsets.only(top: 80, bottom: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          accountColor.withValues(alpha: 0.15),
                          AppColors.background,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isPrivate ? '••••' : '₹${NumberFormat('#,##,##0', 'en_IN').format(ab.balanceInPaise.abs() / 100.0)}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: ab.balanceInPaise < 0 || account.type == AccountType.creditCard
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          account.type == AccountType.creditCard ? 'Outstanding' : 'Available Balance',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Account Info Cards ─────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (account.type == AccountType.creditCard && account.creditLimitInPaise != null)
                        Expanded(
                          child: _InfoTile(
                            label: 'CREDIT LIMIT',
                            value: '₹${(account.creditLimitInPaise! / 100).toStringAsFixed(0)}',
                            icon: Icons.speed_rounded,
                            color: Colors.blueAccent,
                          ),
                        ),
                      if (account.accountNumberLast4 != null) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: _InfoTile(
                            label: 'ACCOUNT',
                            value: '•••• ${account.accountNumberLast4}',
                            icon: Icons.numbers_rounded,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // ── Transactions Section Header ────────────────────────────────
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Text(
                    'TRANSACTIONS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textTertiary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              // ── Transaction List ──────────────────────────────────────────
              txnsAsync.when(
                loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
                error: (e, __) => SliverToBoxAdapter(child: Center(child: Text('Error: $e'))),
                data: (txns) {
                  if (txns.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text('No transactions for this account',
                            style: TextStyle(color: AppColors.textTertiary)),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final txn = txns[index];
                        return _SimpleTxnTile(transaction: txn);
                      },
                      childCount: txns.length,
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        );
      },
    );
  }

  void _showEditSheet(BuildContext context, Account account) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AccountFormSheet(account: account),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textTertiary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _SimpleTxnTile extends ConsumerWidget {
  final Transaction transaction;

  const _SimpleTxnTile({required this.transaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPrivate = ref.watch(privacyModeProvider);
    final isExpense = transaction.type == TransactionType.expense;
    final isTransfer = transaction.type == TransactionType.transfer;
    
    final color = isExpense ? AppColors.primary : isTransfer ? AppColors.textSecondary : AppColors.income;
    final sign = isExpense ? '−' : isTransfer ? '↔' : '+';
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.payee?.isNotEmpty == true ? transaction.payee! : 'Transaction',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Text(
                  DateFormat('dd MMM · HH:mm').format(transaction.transactionDate),
                  style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          Text(
            isPrivate ? '••••' : '$sign ₹${(transaction.amountInPaise / 100).toStringAsFixed(0)}',
            style: TextStyle(fontWeight: FontWeight.w700, color: color),
          ),
        ],
      ),
    );
  }
}
