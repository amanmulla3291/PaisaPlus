// lib/features/subscriptions/widgets/subscription_card.dart
// ─────────────────────────────────────────────────────────────────────────────
// Premium card for tracking digital subscriptions and bills.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/subscription.dart';
import '../../../core/isar/schemas/recurring_rule.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/providers/service_providers.dart';

class SubscriptionCard extends ConsumerWidget {
  final Subscription subscription;
  final VoidCallback? onTap;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPrivate = ref.watch(privacyModeProvider);
    final currencyFormat = NumberFormat.simpleCurrency(locale: 'en_IN', decimalDigits: 0);
    final amountStr = isPrivate ? '••••' : currencyFormat.format(subscription.amountInPaise / 100);
    
    final now = DateTime.now();
    final effectiveNextBill = subscription.nextBillingDate;
    final daysLeft = effectiveNextBill.difference(now).inDays;

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
                  color: Color(subscription.colorValue).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  IconData(subscription.iconCodePoint, fontFamily: 'MaterialIcons'),
                  color: Color(subscription.colorValue),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.serviceName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Next bill in $daysLeft days',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: daysLeft <= 3 ? AppColors.warning : AppColors.textSecondary,
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
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subscription.frequency == RecurringFrequency.monthly ? '/ mo' : '/ yr',
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
        ),
      ),
    );
  }
}
