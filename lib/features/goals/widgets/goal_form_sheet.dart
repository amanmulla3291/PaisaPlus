// lib/features/goals/widgets/goal_form_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet for creating/editing a savings goal.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../core/isar/schemas/goal.dart';
import '../../../core/isar/providers/service_providers.dart';

class GoalFormSheet extends ConsumerStatefulWidget {
  final Goal? goal;

  const GoalFormSheet({super.key, this.goal});

  @override
  ConsumerState<GoalFormSheet> createState() => _GoalFormSheetState();
}

class _GoalFormSheetState extends ConsumerState<GoalFormSheet> {
  final _nameController = TextEditingController();
  final _targetController = TextEditingController();
  final _currentController = TextEditingController();
  
  DateTime? _deadline;
  int _colorValue = AppColors.chartColors[2].toARGB32();
  int _iconCodePoint = Icons.savings_rounded.codePoint;

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _nameController.text = widget.goal!.name;
      _targetController.text = (widget.goal!.targetAmountInPaise / 100).toStringAsFixed(0);
      _currentController.text = (widget.goal!.savedAmountInPaise / 100).toStringAsFixed(0);
      _deadline = widget.goal!.targetDate;
      _colorValue = widget.goal!.colorValue;
      _iconCodePoint = widget.goal!.iconCodePoint;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    _currentController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final target = int.tryParse(_targetController.text.trim()) ?? 0;
    final current = int.tryParse(_currentController.text.trim()) ?? 0;

    if (name.isEmpty || target <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final service = await ref.read(goalServiceProvider.future);
    
    final goal = widget.goal ?? Goal();
    goal
      ..name = name
      ..targetAmountInPaise = target * 100
      ..savedAmountInPaise = current * 100
      ..targetDate = _deadline
      ..colorValue = _colorValue
      ..iconCodePoint = _iconCodePoint;

    if (widget.goal == null) {
      await service.createGoal(goal);
    } else {
      await service.updateGoal(goal);
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
              widget.goal == null ? 'Set New Goal' : 'Edit Goal',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _inputDecoration('Goal Name (e.g. New Car)', Icons.flag_rounded),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _targetController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Nunito', fontWeight: FontWeight.w700),
                    decoration: _inputDecoration('Target Amount', Icons.ads_click_rounded),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _currentController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Nunito', fontWeight: FontWeight.w700),
                    decoration: _inputDecoration('Current Saved', Icons.savings_rounded),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Deadline selection
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _deadline ?? DateTime.now().add(const Duration(days: 365)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
                );
                if (date != null) setState(() => _deadline = date);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              tileColor: AppColors.surfaceVariant,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              leading: const Icon(Icons.calendar_month_rounded, color: AppColors.textTertiary),
              title: Text(
                _deadline == null ? 'Target Date (Optional)' : DateFormat('dd MMM, yyyy').format(_deadline!),
                style: TextStyle(
                  color: _deadline == null ? AppColors.textTertiary : AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
            ),
            const SizedBox(height: 24),

            // Color selection
            const Text(
              'Goal Color',
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
                  widget.goal == null ? 'Start Saving' : 'Save Changes',
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
