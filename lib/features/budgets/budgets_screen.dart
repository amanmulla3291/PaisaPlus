// lib/features/budgets/budgets_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// The main Budgets management screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../shared/theme/app_colors.dart';
import '../../core/isar/providers/budget_providers.dart';
import '../../core/isar/providers/service_providers.dart';
import 'widgets/budget_card.dart';
import 'widgets/budget_form_sheet.dart';

class BudgetsScreen extends ConsumerStatefulWidget {
  const BudgetsScreen({super.key});

  @override
  ConsumerState<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends ConsumerState<BudgetsScreen> {
  final DateTime _currentMonth = DateTime.now();

  void _showAddBudget() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BudgetFormSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final budgetsAsync = ref.watch(activeBudgetsProvider);
    final totalSpentAsync = ref.watch(monthlyExpenseInPaiseProvider(_currentMonth));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Budgets',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Future: History/Archive
            },
            icon: const Icon(Icons.history_rounded, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: budgetsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
        data: (budgets) {
          if (budgets.isEmpty) {
            return _buildEmptyState();
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              _buildSummaryCard(budgets, totalSpentAsync.value ?? 0),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  'Active Budgets',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ...budgets.map((budget) {
                final progressAsync = ref.watch(budgetProgressProvider((budgetId: budget.id, month: _currentMonth)));
                return progressAsync.when(
                  loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (progress) => BudgetCard(
                    progress: progress,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => BudgetFormSheet(budget: budget),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddBudget,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Budget', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildSummaryCard(List<dynamic> budgets, int totalSpent) {
    final totalBudget = budgets.fold<int>(0, (sum, b) => sum + (b.amountInPaise as int));
    final percentage = totalBudget == 0 ? 0.0 : totalSpent / totalBudget;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.surfaceVariant,
            AppColors.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Monthly Budget',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${NumberFormat('#,##,###').format(totalBudget / 100)}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (percentage > 1.0 ? AppColors.error : AppColors.success).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(percentage * 100).toInt()}%',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: percentage > 1.0 ? AppColors.error : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage.clamp(0.0, 1.0),
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryLight,
                        AppColors.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat('Spent', '₹${NumberFormat('#,##,###').format(totalSpent / 100)}', AppColors.textPrimary),
              _buildMiniStat('Available', '₹${NumberFormat('#,##,###').format((totalBudget - totalSpent).clamp(0, totalBudget) / 100)}', AppColors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textTertiary, fontSize: 12)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_balance_wallet_outlined, size: 48, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Budgets Yet',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Set monthly limits for your categories to keep your spending in check.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
