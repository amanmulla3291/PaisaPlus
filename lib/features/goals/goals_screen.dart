// lib/features/goals/goals_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// The main Goals management screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../shared/theme/app_colors.dart';
import '../../core/isar/providers/goal_providers.dart';
import 'widgets/goal_card.dart';
import 'widgets/goal_form_sheet.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  void _showAddGoal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const GoalFormSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeGoalsAsync = ref.watch(activeGoalsProvider);
    final completedGoalsAsync = ref.watch(completedGoalsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Goals',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: activeGoalsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
        data: (goals) {
          if (goals.isEmpty) {
            return _buildEmptyState();
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              _buildOverallSummary(goals),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  'In Progress',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ...goals.map((goal) => GoalCard(
                goal: goal,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => GoalFormSheet(goal: goal),
                  );
                },
              )),
              
              completedGoalsAsync.when(
                data: (completed) {
                  if (completed.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 32, 20, 12),
                        child: Text(
                          'Completed',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      ...completed.map((goal) => Opacity(
                        opacity: 0.7,
                        child: GoalCard(goal: goal),
                      )),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddGoal,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Goal', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildOverallSummary(List<dynamic> goals) {
    final totalTarget = goals.fold<int>(0, (sum, g) => sum + (g.targetAmountInPaise as int));
    final totalSaved = goals.fold<int>(0, (sum, g) => sum + (g.savedAmountInPaise as int));
    final percentage = totalTarget == 0 ? 0.0 : totalSaved / totalTarget;

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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.savings_rounded, color: AppColors.success, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Savings Progress',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${NumberFormat('#,##,###').format(totalSaved / 100)}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: AppColors.surfaceVariant,
            color: AppColors.success,
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Target: ₹${NumberFormat('#,##,###').format(totalTarget / 100)}',
                style: const TextStyle(color: AppColors.textTertiary, fontSize: 12),
              ),
              Text(
                '₹${NumberFormat('#,##,###').format((totalTarget - totalSaved).clamp(0, totalTarget) / 100)} left',
                style: const TextStyle(color: AppColors.textTertiary, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
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
            child: const Icon(Icons.flag_outlined, size: 48, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 24),
          const Text(
            'Dream Big, Start Small',
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
              'Create a savings goal for a new car, a vacation, or an emergency fund.',
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
