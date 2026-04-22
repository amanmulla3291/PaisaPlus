// lib/features/budgets/widgets/budget_form_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet for creating/editing a budget.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/budget.dart';
import '../../../core/isar/providers/service_providers.dart';

class BudgetFormSheet extends ConsumerStatefulWidget {
  final Budget? budget;

  const BudgetFormSheet({super.key, this.budget});

  @override
  ConsumerState<BudgetFormSheet> createState() => _BudgetFormSheetState();
}

class _BudgetFormSheetState extends ConsumerState<BudgetFormSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  
  List<int> _selectedCategoryIds = [];
  BudgetPeriod _period = BudgetPeriod.monthly;
  int _colorValue = AppColors.chartColors[0].toARGB32();
  int _iconCodePoint = Icons.account_balance_wallet_rounded.codePoint;
  bool _rolloverEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.budget != null) {
      _nameController.text = widget.budget!.name;
      _amountController.text = (widget.budget!.amountInPaise / 100).toStringAsFixed(0);
      _selectedCategoryIds = List.from(widget.budget!.categoryIds);
      _period = widget.budget!.period;
      _colorValue = widget.budget!.colorValue;
      _iconCodePoint = widget.budget!.iconCodePoint;
      _rolloverEnabled = widget.budget!.rolloverEnabled;
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

    if (name.isEmpty || amount <= 0 || _selectedCategoryIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final service = await ref.read(budgetServiceProvider.future);
    
    final budget = widget.budget ?? Budget();
    budget
      ..name = name
      ..amountInPaise = amount * 100
      ..categoryIds = _selectedCategoryIds
      ..period = _period
      ..colorValue = _colorValue
      ..iconCodePoint = _iconCodePoint
      ..rolloverEnabled = _rolloverEnabled;

    if (widget.budget == null) {
      await service.createBudget(budget);
    } else {
      await service.updateBudget(budget);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(watchExpenseCategoriesProvider);

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
            // Handle bar
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
              widget.budget == null ? 'Create Budget' : 'Edit Budget',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // Name Input
            TextField(
              controller: _nameController,
              autofocus: widget.budget == null,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _inputDecoration('Budget Name (e.g. Shopping)', Icons.edit_rounded),
            ),
            const SizedBox(height: 16),

            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Nunito', fontWeight: FontWeight.w700),
              decoration: _inputDecoration('Monthly Limit (₹)', Icons.currency_rupee_rounded),
            ),
            const SizedBox(height: 24),

            // Category Selection
            const Text(
              'Select Categories',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            categoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Text('Error loading categories'),
              data: (categories) => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((cat) {
                  final isSelected = _selectedCategoryIds.contains(cat.id);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedCategoryIds.remove(cat.id);
                        } else {
                          _selectedCategoryIds.add(cat.id);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(cat.colorValue).withValues(alpha: 0.2) : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Color(cat.colorValue) : AppColors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            IconData(cat.iconCodePoint, fontFamily: 'MaterialIcons'),
                            size: 14,
                            color: isSelected ? Color(cat.colorValue) : AppColors.textTertiary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            cat.name,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Color selection
            const Text(
              'Budget Color',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: AppColors.chartColors.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final color = AppColors.chartColors[index];
                  final isSelected = _colorValue == color.toARGB32();
                  return GestureDetector(
                    onTap: () => setState(() => _colorValue = color.toARGB32()),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
                      ),
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Rollover Switch
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Enable Rollover',
                style: TextStyle(color: AppColors.textPrimary, fontFamily: 'Inter', fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Carry over unspent balance to next month',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              value: _rolloverEnabled,
              activeThumbColor: AppColors.primary,
              onChanged: (v) => setState(() => _rolloverEnabled = v),
            ),
            const SizedBox(height: 32),

            // Save Button
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
                  widget.budget == null ? 'Create Budget' : 'Save Changes',
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
