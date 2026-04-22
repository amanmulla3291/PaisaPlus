// lib/features/recurring/widgets/recurring_card.dart
// ─────────────────────────────────────────────────────────────────────────────
// Card for displaying a recurring transaction rule.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/recurring_rule.dart';
import '../../../core/isar/schemas/transaction.dart';

class RecurringCard extends StatelessWidget {
  final RecurringRule rule;
  final VoidCallback? onTap;

  const RecurringCard({
    super.key,
    required this.rule,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = rule.transactionType == TransactionType.income;
    final color = isIncome ? AppColors.income : AppColors.expense;
    
    final currencyFormat = NumberFormat.simpleCurrency(locale: 'en_IN', decimalDigits: 0);
    final amountStr = currencyFormat.format(rule.amountInPaise / 100);
    
    String frequencyStr = '';
    switch (rule.frequency) {
      case RecurringFrequency.daily: frequencyStr = 'Daily'; break;
      case RecurringFrequency.weekly: frequencyStr = 'Weekly'; break;
      case RecurringFrequency.biweekly: frequencyStr = 'Bi-weekly'; break;
      case RecurringFrequency.monthly: frequencyStr = 'Monthly'; break;
      case RecurringFrequency.quarterly: frequencyStr = 'Quarterly'; break;
      case RecurringFrequency.yearly: frequencyStr = 'Yearly'; break;
    }

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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  isIncome ? Icons.add_chart_rounded : Icons.repeat_rounded,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rule.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$frequencyStr • Started: ${DateFormat('dd MMM yyyy').format(rule.startDate)}',
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
                    amountStr,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                  if (!rule.isActive)
                    const Text(
                      'Paused',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: AppColors.error,
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
