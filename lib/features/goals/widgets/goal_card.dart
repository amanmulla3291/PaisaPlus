// lib/features/goals/widgets/goal_card.dart
// ─────────────────────────────────────────────────────────────────────────────
// Premium card for displaying savings goal progress.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/goal.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/providers/service_providers.dart';

class GoalCard extends ConsumerWidget {
  final Goal goal;
  final VoidCallback? onTap;

  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = goal.targetAmountInPaise == 0 
        ? 0.0 
        : (goal.savedAmountInPaise / goal.targetAmountInPaise).clamp(0.0, 1.0);
    final isCompleted = goal.isCompleted;
    final isPrivate = ref.watch(privacyModeProvider);
    
    final currencyFormat = NumberFormat.compactSimpleCurrency(locale: 'en_IN', decimalDigits: 0);
    final currentStr = isPrivate ? '••••' : currencyFormat.format(goal.savedAmountInPaise / 100);
    final targetStr = isPrivate ? '••••' : currencyFormat.format(goal.targetAmountInPaise / 100);
    final remainingStr = isPrivate 
        ? '•••• to go' 
        : '₹${currencyFormat.format((goal.targetAmountInPaise - goal.savedAmountInPaise).clamp(0, goal.targetAmountInPaise) / 100)} to go';

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
                      color: Color(goal.colorValue).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconData(goal.iconCodePoint, fontFamily: 'MaterialIcons'),
                      color: Color(goal.colorValue),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          isCompleted ? 'Goal achieved! 🎉' : remainingStr,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: isCompleted ? AppColors.success : AppColors.textSecondary,
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
                      color: isCompleted ? AppColors.success : AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                    widthFactor: percentage,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(goal.colorValue).withValues(alpha: 0.7),
                            Color(goal.colorValue),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$currentStr of $targetStr',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (goal.targetDate != null)
                    Text(
                      DateFormat('MMM yyyy').format(goal.targetDate!),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppColors.textTertiary,
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
