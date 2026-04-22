// lib/features/accounts/widgets/account_form_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet for creating/editing an Account (Bank, Cash, UPI, Credit Card).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/schemas/account.dart';
import '../../../shared/theme/app_colors.dart';

class AccountFormSheet extends ConsumerStatefulWidget {
  final Account? account;

  const AccountFormSheet({super.key, this.account});

  @override
  ConsumerState<AccountFormSheet> createState() => _AccountFormSheetState();
}

class _AccountFormSheetState extends ConsumerState<AccountFormSheet> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _last4Controller = TextEditingController();
  final _limitController = TextEditingController();

  AccountType _type = AccountType.bankAccount;
  int _colorValue = AppColors.chartColors[0].toARGB32();
  int _iconCodePoint = Icons.account_balance_rounded.codePoint;
  bool _isExcluded = false;

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      _nameController.text = widget.account!.name;
      _balanceController.text =
          (widget.account!.openingBalanceInPaise / 100).toStringAsFixed(0);
      _last4Controller.text = widget.account!.accountNumberLast4 ?? '';
      _limitController.text = widget.account!.creditLimitInPaise != null
          ? (widget.account!.creditLimitInPaise! / 100).toStringAsFixed(0)
          : '';
      _type = widget.account!.type;
      _colorValue = widget.account!.colorValue;
      _iconCodePoint = widget.account!.iconCodePoint;
      _isExcluded = widget.account!.isExcludedFromTotal;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _last4Controller.dispose();
    _limitController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final balance = int.tryParse(_balanceController.text.trim()) ?? 0;
    final limit = int.tryParse(_limitController.text.trim());

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an account name')),
      );
      return;
    }

    final service = await ref.read(accountServiceProvider.future);
    final account = widget.account ?? Account();

    account
      ..name = name
      ..type = _type
      ..openingBalanceInPaise = balance * 100
      ..openingBalanceDate = widget.account?.openingBalanceDate ?? DateTime.now()
      ..accountNumberLast4 = _last4Controller.text.isEmpty ? null : _last4Controller.text
      ..creditLimitInPaise = (_type == AccountType.creditCard && limit != null) ? limit * 100 : null
      ..colorValue = _colorValue
      ..iconCodePoint = _iconCodePoint
      ..isExcludedFromTotal = _isExcluded;

    if (widget.account == null) {
      await service.addAccount(account);
    } else {
      await service.updateAccount(account);
    }

    if (mounted) {
      // Invalidate balances to refresh UI
      ref.invalidate(allAccountBalancesProvider);
      ref.invalidate(netWorthInPaiseProvider);
      Navigator.pop(context);
    }
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
            Row(
              children: [
                _buildIconPicker(),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    autofocus: widget.account == null,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Account Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),

            // ── Account Type ─────────────────────────────────────────────────
            const Text(
              'ACCOUNT TYPE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.textTertiary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildTypeSelector(),
            const SizedBox(height: 24),

            // ── Opening Balance ──────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'OPENING BALANCE',
                    controller: _balanceController,
                    hint: '0',
                    prefix: '₹ ',
                    keyboardType: TextInputType.number,
                  ),
                ),
                if (_type == AccountType.creditCard) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      label: 'CREDIT LIMIT',
                      controller: _limitController,
                      hint: '0',
                      prefix: '₹ ',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),

            // ── Meta Details ─────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'LAST 4 DIGITS',
                    controller: _last4Controller,
                    hint: 'Optional',
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EXCLUDE TOTAL',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textTertiary,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Switch.adaptive(
                        value: _isExcluded,
                        onChanged: (val) => setState(() => _isExcluded = val),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Color Picker ─────────────────────────────────────────────────
            const Text(
              'THEME COLOR',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.textTertiary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildColorPicker(),
            const SizedBox(height: 32),

            // ── Save Button ──────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  widget.account == null ? 'Create Account' : 'Save Changes',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? prefix,
    TextInputType? keyboardType,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: AppColors.textTertiary,
            letterSpacing: 1.0,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          style: const TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            counterText: '',
            hintStyle: const TextStyle(color: AppColors.textTertiary),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector() {
    final types = [
      (AccountType.bankAccount, 'Bank', Icons.account_balance_rounded),
      (AccountType.cash, 'Cash', Icons.wallet_rounded),
      (AccountType.digitalWallet, 'UPI/Wallet', Icons.account_balance_wallet_rounded),
      (AccountType.creditCard, 'Credit Card', Icons.credit_card_rounded),
      (AccountType.investment, 'Invest', Icons.trending_up_rounded),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: types.map((t) {
          final isSelected = _type == t.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(t.$2),
              selected: isSelected,
              onSelected: (val) {
                if (val) {
                  setState(() {
                    _type = t.$1;
                    _iconCodePoint = t.$3.codePoint;
                  });
                }
              },
              backgroundColor: AppColors.surfaceVariant,
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                fontSize: 12,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 1.5 : 0.5,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIconPicker() {
    return GestureDetector(
      onTap: () {
        // Simple icon toggle for now
        final icons = [
          Icons.account_balance_rounded,
          Icons.wallet_rounded,
          Icons.credit_card_rounded,
          Icons.account_balance_wallet_rounded,
          Icons.savings_rounded,
          Icons.trending_up_rounded,
        ];
        final index = icons.indexWhere((i) => i.codePoint == _iconCodePoint);
        setState(() {
          _iconCodePoint = icons[(index + 1) % icons.length].codePoint;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(_colorValue).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(_colorValue).withValues(alpha: 0.3)),
        ),
        child: Icon(
          IconData(_iconCodePoint, fontFamily: 'MaterialIcons'),
          color: Color(_colorValue),
          size: 28,
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppColors.chartColors.length,
        itemBuilder: (context, index) {
          final color = AppColors.chartColors[index];
          final isSelected = _colorValue == color.toARGB32();
          return GestureDetector(
            onTap: () => setState(() => _colorValue = color.toARGB32()),
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 3)
                    : null,
                boxShadow: isSelected
                    ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 2)]
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
