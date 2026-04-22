// lib/features/loans/widgets/loan_payment_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet for recording a loan repayment or receipt.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/loan.dart';
import '../../../core/isar/providers/service_providers.dart';

class LoanPaymentSheet extends ConsumerStatefulWidget {
  final Loan loan;

  const LoanPaymentSheet({super.key, required this.loan});

  @override
  ConsumerState<LoanPaymentSheet> createState() => _LoanPaymentSheetState();
}

class _LoanPaymentSheetState extends ConsumerState<LoanPaymentSheet> {
  final _amountController = TextEditingController();
  int? _selectedAccountId;
  final DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _amountController.text = (widget.loan.outstandingAmountInPaise / 100).toStringAsFixed(0);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _record() async {
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0 || _selectedAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter amount and select account')),
      );
      return;
    }

    final categoryId = await ref.read(categoryServiceProvider.future).then((s) => s.getTransferCategoryId());
    final service = await ref.read(loanServiceProvider.future);
    await service.recordPayment(
      loanId: widget.loan.id,
      amountInPaise: amount * 100,
      accountId: _selectedAccountId!,
      categoryId: categoryId ?? 0,
      date: _date,
      note: 'Payment for ${widget.loan.name}',
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(watchActiveAccountsProvider);
    final isLent = widget.loan.loanType == LoanType.lent;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 24),
            
            Text(
              isLent ? 'Record Receipt' : 'Record Payment',
              style: const TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Nunito', fontSize: 24, fontWeight: FontWeight.w800),
              decoration: InputDecoration(
                hintText: '0',
                prefixText: '₹ ',
                filled: true,
                fillColor: AppColors.surfaceVariant,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),

            const Text('Account', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            accountsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('Error loading accounts'),
              data: (accounts) => SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: accounts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final acc = accounts[index];
                    final isSelected = _selectedAccountId == acc.id;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedAccountId = acc.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                        ),
                        child: Center(
                          child: Text(
                            acc.name,
                            style: TextStyle(color: isSelected ? AppColors.primary : AppColors.textSecondary, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _record,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLent ? AppColors.success : AppColors.expense,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Record Transaction', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
