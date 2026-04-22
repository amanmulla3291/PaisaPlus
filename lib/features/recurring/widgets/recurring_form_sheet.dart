// lib/features/recurring/widgets/recurring_form_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet for creating/editing a recurring transaction rule.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/recurring_rule.dart';
import '../../../core/isar/schemas/transaction.dart';
import '../../../core/isar/providers/service_providers.dart';

class RecurringFormSheet extends ConsumerStatefulWidget {
  final RecurringRule? rule;

  const RecurringFormSheet({super.key, this.rule});

  @override
  ConsumerState<RecurringFormSheet> createState() => _RecurringFormSheetState();
}

class _RecurringFormSheetState extends ConsumerState<RecurringFormSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  
  TransactionType _type = TransactionType.expense;
  RecurringFrequency _frequency = RecurringFrequency.monthly;
  int? _selectedCategoryId;
  int? _selectedAccountId;
  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.rule != null) {
      _nameController.text = widget.rule!.name;
      _amountController.text = (widget.rule!.amountInPaise / 100).toStringAsFixed(0);
      _type = widget.rule!.transactionType;
      _frequency = widget.rule!.frequency;
      _selectedCategoryId = widget.rule!.categoryId;
      _selectedAccountId = widget.rule!.accountId;
      _startDate = widget.rule!.startDate;
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

    if (name.isEmpty || amount <= 0 || _selectedCategoryId == null || _selectedAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final service = await ref.read(recurringRuleServiceProvider.future);
    
    final rule = widget.rule ?? RecurringRule();
    rule
      ..name = name
      ..amountInPaise = amount * 100
      ..transactionType = _type
      ..frequency = _frequency
      ..categoryId = _selectedCategoryId!
      ..accountId = _selectedAccountId!
      ..startDate = widget.rule == null ? _startDate : rule.startDate;

    if (widget.rule == null) {
      await service.createRule(rule);
    } else {
      await service.updateRule(rule);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = _type == TransactionType.income 
        ? ref.watch(watchIncomeCategoriesProvider) 
        : ref.watch(watchExpenseCategoriesProvider);
    final accountsAsync = ref.watch(watchActiveAccountsProvider);

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
              widget.rule == null ? 'New Recurring Rule' : 'Edit Rule',
              style: const TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 24),

            // Type Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  _typeTab(TransactionType.expense, 'Expense', AppColors.expense),
                  _typeTab(TransactionType.income, 'Income', AppColors.income),
                ],
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _inputDecoration('Rule Name (e.g. Rent)', Icons.title_rounded),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Nunito', fontWeight: FontWeight.w700),
              decoration: _inputDecoration('Amount', Icons.payments_rounded),
            ),
            const SizedBox(height: 24),

            // Frequency Dropdown
            DropdownButtonFormField<RecurringFrequency>(
              initialValue: _frequency,
              dropdownColor: AppColors.surfaceVariant,
              decoration: _inputDecoration('Frequency', Icons.repeat_rounded),
              items: RecurringFrequency.values.map((f) => DropdownMenuItem(
                value: f,
                child: Text(f.name.toUpperCase(), style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
              )).toList(),
              onChanged: (v) => setState(() => _frequency = v!),
            ),
            const SizedBox(height: 24),

            // Start Date
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) setState(() => _startDate = date);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.surfaceVariant,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              leading: const Icon(Icons.calendar_today_rounded, color: AppColors.textTertiary),
              title: Text(DateFormat('dd MMM, yyyy').format(_startDate), style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
              subtitle: const Text('Start Date / Next Run', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            ),
            const SizedBox(height: 24),

            // Category & Account selection (simplified)
            const Text('Category', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            categoriesAsync.when(
              data: (cats) => _pickerList(cats, _selectedCategoryId, (id) => setState(() => _selectedCategoryId = id)),
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('Error'),
            ),
            const SizedBox(height: 16),
            const Text('Account', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            accountsAsync.when(
              data: (accs) => _pickerList(accs, _selectedAccountId, (id) => setState(() => _selectedAccountId = id)),
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('Error'),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: Text(widget.rule == null ? 'Create Rule' : 'Save Changes', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _typeTab(TransactionType type, String label, Color color) {
    final isSelected = _type == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _type = type;
          _selectedCategoryId = null; // Reset category when type changes
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: isSelected ? AppColors.background : Colors.transparent, borderRadius: BorderRadius.circular(10)),
          child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? color : AppColors.textTertiary)),
        ),
      ),
    );
  }

  Widget _pickerList(List<dynamic> items, int? selectedId, Function(int) onSelect) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedId == item.id;
          return GestureDetector(
            onTap: () => onSelect(item.id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
              ),
              child: Center(child: Text(item.name, style: TextStyle(color: isSelected ? AppColors.primary : AppColors.textSecondary, fontSize: 12))),
            ),
          );
        },
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
