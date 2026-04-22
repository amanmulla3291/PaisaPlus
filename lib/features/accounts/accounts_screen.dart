// lib/features/accounts/accounts_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// Screen for managing all accounts (Bank, Cash, etc.) with reordering.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/schemas/account.dart';
import '../../../shared/theme/app_colors.dart';
import 'widgets/account_form_sheet.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(watchActiveAccountsProvider);
    final balancesAsync = ref.watch(allAccountBalancesProvider);
    final isPrivate = ref.watch(privacyModeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Manage Accounts',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: AppColors.primary),
            onPressed: () => _showAddSheet(context),
          ),
        ],
      ),
      body: accountsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('Error: $e')),
        data: (accounts) {
          if (accounts.isEmpty) {
            return _buildEmptyState(context);
          }

          return balancesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, __) => Center(child: Text('Error: $e')),
            data: (balances) {
              return ReorderableListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: accounts.length,
                onReorder: (oldIdx, newIdx) => _onReorder(ref, accounts, oldIdx, newIdx),
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  final ab = balances[account.id];
                  return _AccountListTile(
                    key: ValueKey(account.id),
                    account: account,
                    balance: ab?.balanceInPaise ?? 0,
                    isPrivate: isPrivate,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.account_balance_rounded,
              size: 64, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          const Text('No accounts found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _showAddSheet(context),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Account'),
          ),
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AccountFormSheet(),
    );
  }

  Future<void> _onReorder(
      WidgetRef ref, List<Account> accounts, int oldIdx, int newIdx) async {
    if (newIdx > oldIdx) newIdx -= 1;
    final item = accounts.removeAt(oldIdx);
    accounts.insert(newIdx, item);

    final service = await ref.read(accountServiceProvider.future);
    final updates = accounts.asMap().entries.map((e) {
      return (id: e.value.id, sortOrder: e.key);
    }).toList();

    await service.reorder(updates);
    ref.invalidate(watchActiveAccountsProvider);
  }
}

class _AccountListTile extends StatelessWidget {
  final Account account;
  final int balance;
  final bool isPrivate;

  const _AccountListTile({
    super.key,
    required this.account,
    required this.balance,
    required this.isPrivate,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(account.colorValue);
    final formatter = NumberFormat('#,##,##0', 'en_IN');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            IconData(account.iconCodePoint, fontFamily: 'MaterialIcons'),
            color: color,
            size: 20,
          ),
        ),
        title: Text(
          account.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Text(
          _getAccountTypeLabel(account.type),
          style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isPrivate ? '••••' : '₹${formatter.format(balance.abs() / 100.0)}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: balance < 0 || account.type == AccountType.creditCard
                    ? AppColors.primary
                    : AppColors.textPrimary,
              ),
            ),
            const Icon(Icons.drag_indicator_rounded,
                size: 16, color: AppColors.textTertiary),
          ],
        ),
        onTap: () => context.push('/accounts/${account.id}'),
      ),
    );
  }

  String _getAccountTypeLabel(AccountType type) {
    switch (type) {
      case AccountType.cash: return 'Cash';
      case AccountType.bankAccount: return 'Bank Account';
      case AccountType.creditCard: return 'Credit Card';
      case AccountType.digitalWallet: return 'Wallet/UPI';
      case AccountType.investment: return 'Investment';
      case AccountType.loan: return 'Loan';
      case AccountType.other: return 'Other';
    }
  }
}
