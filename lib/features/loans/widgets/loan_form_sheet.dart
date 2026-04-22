// lib/features/loans/widgets/loan_form_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet for creating/editing a loan or debt.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/loan.dart';
import '../../../core/isar/providers/service_providers.dart';

class LoanFormSheet extends ConsumerStatefulWidget {
  final Loan? loan;

  const LoanFormSheet({super.key, this.loan});

  @override
  ConsumerState<LoanFormSheet> createState() => _LoanFormSheetState();
}

class _LoanFormSheetState extends ConsumerState<LoanFormSheet> {
  final _nameController = TextEditingController();
  final _personController = TextEditingController();
  final _amountController = TextEditingController();
  final _interestController = TextEditingController();
  
  LoanType _type = LoanType.borrowed;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    if (widget.loan != null) {
      _nameController.text = widget.loan!.name;
      _personController.text = widget.loan!.personName;
      _amountController.text = (widget.loan!.principalAmountInPaise / 100).toStringAsFixed(0);
      _interestController.text = widget.loan!.interestRatePercent100 != null 
          ? (widget.loan!.interestRatePercent100! / 100).toString() 
          : '';
      _type = widget.loan!.loanType;
      _dueDate = widget.loan!.dueDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _personController.dispose();
    _amountController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final person = _personController.text.trim();
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    final interest = double.tryParse(_interestController.text.trim());

    if (name.isEmpty || person.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final service = await ref.read(loanServiceProvider.future);
    
    final loan = widget.loan ?? Loan();
    loan
      ..name = name
      ..personName = person
      ..principalAmountInPaise = amount * 100
      ..outstandingAmountInPaise = widget.loan == null ? amount * 100 : loan.outstandingAmountInPaise
      ..interestRatePercent100 = interest != null ? (interest * 100).toInt() : null
      ..loanType = _type
      ..dueDate = _dueDate;

    if (widget.loan == null) {
      await service.createLoan(loan);
    } else {
      await service.updateLoan(loan);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              widget.loan == null ? 'Record New Loan/Debt' : 'Edit Loan',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // Loan Type Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  _typeTab(LoanType.borrowed, 'Borrowed (Debt)', AppColors.expense),
                  _typeTab(LoanType.lent, 'Lent (Asset)', AppColors.income),
                ],
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _inputDecoration('Loan Purpose (e.g. Home Loan)', Icons.description_rounded),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _personController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _inputDecoration(_type == LoanType.borrowed ? 'Lender Name' : 'Borrower Name', Icons.person_rounded),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Nunito', fontWeight: FontWeight.w700),
                    decoration: _inputDecoration('Total Principal', Icons.payments_rounded),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _interestController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Nunito'),
                    decoration: _inputDecoration('Interest % (Opt)', Icons.percent_rounded),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Due Date
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 90)),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 30)),
                );
                if (date != null) setState(() => _dueDate = date);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.surfaceVariant,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              leading: const Icon(Icons.event_note_rounded, color: AppColors.textTertiary),
              title: Text(
                _dueDate == null ? 'Due Date (Optional)' : DateFormat('dd MMM, yyyy').format(_dueDate!),
                style: TextStyle(
                  color: _dueDate == null ? AppColors.textTertiary : AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  widget.loan == null ? 'Record Loan' : 'Save Changes',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _typeTab(LoanType type, String label, Color color) {
    final isSelected = _type == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.background : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(color: AppColors.border) : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? color : AppColors.textTertiary,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 14),
      prefixIcon: Icon(icon, color: AppColors.textTertiary, size: 20),
      filled: true,
      fillColor: AppColors.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
