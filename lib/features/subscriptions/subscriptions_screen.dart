// lib/features/subscriptions/subscriptions_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// The main Subscriptions and Bills management screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../shared/theme/app_colors.dart';
import '../../core/isar/providers/subscription_providers.dart';
import 'widgets/subscription_card.dart';
import 'widgets/subscription_form_sheet.dart';

class SubscriptionsScreen extends ConsumerWidget {
  const SubscriptionsScreen({super.key});

  void _showAddSubscription(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SubscriptionFormSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionsAsync = ref.watch(activeSubscriptionsProvider);
    final monthlyCostAsync = ref.watch(monthlySubscriptionCostProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Subscriptions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: subscriptionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(child: Text('Error: $e')),
        data: (subs) {
          if (subs.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              _buildCostSummary(monthlyCostAsync.value ?? 0),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  'My Services',
                  style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ),
              ...subs.map((sub) => SubscriptionCard(
                subscription: sub,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => SubscriptionFormSheet(subscription: sub),
                  );
                },
              )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSubscription(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('Add Service', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildCostSummary(int monthlyCost) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.auto_graph_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Estimated Monthly Burn', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                '₹${NumberFormat('#,##,###').format(monthlyCost / 100)}',
                style: const TextStyle(fontFamily: 'Nunito', fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: AppColors.surfaceVariant, shape: BoxShape.circle),
            child: const Icon(Icons.credit_card_off_rounded, size: 48, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 24),
          const Text('Subscription Fatigue?', style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Track your Netflix, Spotify, or Gym bills. We\'ll help you see exactly where your recurring money goes.',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () => _showAddSubscription(context),
            child: const Text('Add Your First Service', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
