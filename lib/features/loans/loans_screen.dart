// lib/features/loans/loans_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// The main Loans & Debts management screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../shared/theme/app_colors.dart';
import '../../core/isar/providers/loan_providers.dart';
import 'widgets/loan_card.dart';
import 'widgets/loan_form_sheet.dart';
import 'widgets/loan_payment_sheet.dart';

class LoansScreen extends ConsumerStatefulWidget {
  const LoansScreen({super.key});

  @override
  ConsumerState<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends ConsumerState<LoansScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddLoan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoanFormSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final owedAsync = ref.watch(totalOwedProvider);
    final lentAsync = ref.watch(totalLentProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Loans & Debts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildNetPositionCard(owedAsync.value ?? 0, lentAsync.value ?? 0),
          
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textTertiary,
            dividerColor: AppColors.divider,
            tabs: const [
              Tab(text: 'Borrowed'),
              Tab(text: 'Lent'),
            ],
          ),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                _LoanList(type: 'borrowed'),
                _LoanList(type: 'lent'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddLoan,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Loan', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildNetPositionCard(int owed, int lent) {
    final net = lent - owed;
    final isNegative = net < 0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            isNegative ? 'Net Debt' : 'Net Asset',
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${NumberFormat('#,##,###').format(net.abs() / 100)}',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: isNegative ? AppColors.error : AppColors.success,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryItem('Borrowed', owed, AppColors.expense),
              Container(width: 1, height: 30, color: AppColors.divider),
              _summaryItem('Lent', lent, AppColors.income),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, int amount, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: AppColors.textTertiary, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          '₹${NumberFormat('#,##,###').format(amount / 100)}',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _LoanList extends ConsumerWidget {
  final String type;
  const _LoanList({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loansAsync = type == 'borrowed' 
        ? ref.watch(activeBorrowedLoansProvider) 
        : ref.watch(activeLentLoansProvider);

    return loansAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Center(child: Text('Error: $e')),
      data: (loans) {
        if (loans.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type == 'borrowed' ? Icons.south_west_rounded : Icons.north_east_rounded,
                  size: 48,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: 16),
                Text(
                  type == 'borrowed' ? 'No active debts' : 'No active loans',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 100),
          itemCount: loans.length,
          itemBuilder: (context, index) {
            final loan = loans[index];
            return LoanCard(
              loan: loan,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoanFormSheet(loan: loan),
                );
              },
              onPaymentTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LoanPaymentSheet(loan: loan),
                );
              },
            );
          },
        );
      },
    );
  }
}
