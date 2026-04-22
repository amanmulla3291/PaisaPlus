// lib/features/subscriptions/widgets/subscription_form_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet for managing a subscription/recurring bill.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/subscription.dart';
import '../../../core/isar/schemas/recurring_rule.dart';
import '../../../core/isar/providers/service_providers.dart';

class SubscriptionFormSheet extends ConsumerStatefulWidget {
  final Subscription? subscription;

  const SubscriptionFormSheet({super.key, this.subscription});

  @override
  ConsumerState<SubscriptionFormSheet> createState() => _SubscriptionFormSheetState();
}

class _SubscriptionFormSheetState extends ConsumerState<SubscriptionFormSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  
  RecurringFrequency _frequency = RecurringFrequency.monthly;
  int _billingDay = 1;
  int _colorValue = AppColors.chartColors[4].toARGB32();
  int _iconCodePoint = Icons.subscriptions_rounded.codePoint;
  int _reminderDaysBefore = 1;

  @override
  void initState() {
    super.initState();
    if (widget.subscription != null) {
      _nameController.text = widget.subscription!.serviceName;
      _amountController.text = (widget.subscription!.amountInPaise / 100).toStringAsFixed(0);
      _frequency = widget.subscription!.frequency;
      _billingDay = widget.subscription!.nextBillingDate.day;
      _colorValue = widget.subscription!.colorValue;
      _iconCodePoint = widget.subscription!.iconCodePoint;
      _reminderDaysBefore = widget.subscription!.reminderDaysBefore;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;

    if (name.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter name and amount')));
      return;
    }

    final service = await ref.read(subscriptionServiceProvider.future);
    
    // Calculate next billing date based on day
    final now = DateTime.now();
    var nextBill = DateTime(now.year, now.month, _billingDay);
    if (nextBill.isBefore(now)) {
      nextBill = DateTime(now.year, now.month + 1, _billingDay);
    }

    final sub = widget.subscription ?? Subscription();
    sub
      ..serviceName = name
      ..amountInPaise = amount * 100
      ..frequency = _frequency
      ..nextBillingDate = nextBill
      ..colorValue = _colorValue
      ..iconCodePoint = _iconCodePoint
      ..reminderDaysBefore = _reminderDaysBefore;

    if (widget.subscription == null) {
      await service.createSubscription(sub);
    } else {
      await service.updateSubscription(sub);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 24),
            
            Text(widget.subscription == null ? 'Track Subscription' : 'Edit Subscription', style: const TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 24),

            TextField(controller: _nameController, decoration: _inputDecoration('Service Name (e.g. Netflix)', Icons.branding_watermark_rounded)),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(child: TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: _inputDecoration('Amount', Icons.payments_rounded))),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<RecurringFrequency>(
                    initialValue: _frequency,
                    dropdownColor: AppColors.surfaceVariant,
                    decoration: _inputDecoration('Cycle', Icons.refresh_rounded),
                    items: RecurringFrequency.values.map((p) => DropdownMenuItem(value: p, child: Text(p.name.toUpperCase(), style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)))).toList(),
                    onChanged: (v) => setState(() => _frequency = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Billing Day', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 31,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final isSelected = _billingDay == day;
                  return GestureDetector(
                    onTap: () => setState(() => _billingDay = day),
                    child: Container(
                      width: 44,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                      ),
                      child: Center(child: Text('$day', style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400))),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Billing Reminders', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              subtitle: const Text('Get notified 1 day before billing', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              value: _reminderDaysBefore > 0,
              activeThumbColor: AppColors.primary,
              onChanged: (v) => setState(() => _reminderDaysBefore = v ? 1 : 0),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: Text(widget.subscription == null ? 'Track Service' : 'Save Changes', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.textTertiary, size: 20),
      filled: true,
      fillColor: AppColors.surfaceVariant,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
