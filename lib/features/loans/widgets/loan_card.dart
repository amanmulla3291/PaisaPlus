// lib/features/loans/widgets/loan_card.dart
// ─────────────────────────────────────────────────────────────────────────────
// Premium card for displaying loans and debts.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/loan.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/providers/service_providers.dart';

class LoanCard extends ConsumerWidget {
  final Loan loan;
  final VoidCallback? onTap;
  final VoidCallback? onPaymentTap;

  const LoanCard({
    super.key,
    required this.loan,
    this.onTap,
    this.onPaymentTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLent = loan.loanType == LoanType.lent;
    final color = isLent ? AppColors.income : AppColors.expense;
    final isPrivate = ref.watch(privacyModeProvider);
    
    final currencyFormat = NumberFormat.simpleCurrency(locale: 'en_IN', decimalDigits: 0);
    final totalStr = isPrivate ? '••••' : currencyFormat.format(loan.principalAmountInPaise / 100);
    final remainingStr = isPrivate ? '••••' : currencyFormat.format(loan.outstandingAmountInPaise / 100);
    
    final progress = (1.0 - (loan.outstandingAmountInPaise / loan.principalAmountInPaise)).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isLent ? Icons.north_east_rounded : Icons.south_west_rounded,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          isLent ? 'Lent to ${loan.personName}' : 'Borrowed from ${loan.personName}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        remainingStr,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: color,
                        ),
                      ),
                      Text(
                        'of $totalStr',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Progress Bar
              Stack(
                children: [
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (loan.dueDate != null)
                    Row(
                      children: [
                        const Icon(Icons.event_note_rounded, size: 14, color: AppColors.textTertiary),
                        const SizedBox(width: 6),
                        Text(
                          'Due ${DateFormat('dd MMM').format(loan.dueDate!)}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                  
                  if (!loan.isSettled)
                    TextButton.icon(
                      onPressed: onPaymentTap,
                      icon: const Icon(Icons.add_circle_outline_rounded, size: 16),
                      label: Text(isLent ? 'Record Receipt' : 'Record Payment'),
                      style: TextButton.styleFrom(
                        foregroundColor: color,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        visualDensity: VisualDensity.compact,
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
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
