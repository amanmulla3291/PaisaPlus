// lib/features/budgets/widgets/budget_card.dart
// ─────────────────────────────────────────────────────────────────────────────
// Premium card for displaying budget progress.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/services/budget_service.dart';

class BudgetCard extends ConsumerWidget {
  final BudgetProgress progress;
  final VoidCallback? onTap;

  const BudgetCard({
    super.key,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budget = progress.budget;
    final percentage = progress.progressPercentage;
    final isOverBudget = progress.isOverBudget;
    final isPrivate = ref.watch(privacyModeProvider);
    
    // Determine bar color based on percentage
    Color progressColor = AppColors.success;
    if (percentage > 1.0) {
      progressColor = AppColors.error;
    } else if (percentage > 0.8) {
      progressColor = AppColors.warning;
    }

    final currencyFormat = NumberFormat.compactSimpleCurrency(locale: 'en_IN', decimalDigits: 0);
    final spentStr = isPrivate ? '••••' : currencyFormat.format(progress.spentInPaise / 100);
    final limitStr = isPrivate ? '••••' : currencyFormat.format(progress.allocatedInPaise / 100);
    
    final remainingStr = isPrivate 
        ? '•••• remaining'
        : (isOverBudget 
            ? '₹${NumberFormat('#,##,###').format(progress.remainingInPaise.abs() / 100)} over spent'
            : '₹${NumberFormat('#,##,###').format(progress.remainingInPaise / 100)} remaining');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon + Name + Percentage
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(budget.colorValue).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconData(budget.iconCodePoint, fontFamily: 'MaterialIcons'),
                      color: Color(budget.colorValue),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          budget.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          remainingStr,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: isOverBudget && !isPrivate ? AppColors.error : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${(percentage * 100).toInt()}%',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: progressColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Progress Bar
              Stack(
                children: [
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percentage.clamp(0.0, 1.0),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: progressColor,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: progressColor.withValues(alpha: 0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Footer: Spent / Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: spentStr,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: ' of $limitStr',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (budget.rolloverEnabled)
                    const Icon(
                      Icons.sync_alt,
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
