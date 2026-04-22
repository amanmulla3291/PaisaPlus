// lib/features/transactions/quick_add/widgets/quick_add_meta_row.dart
//
// PaisaPlus – QuickAdd Metadata Row
// ------------------------------------
// The compact row below the category picker containing:
//   [Account chip]  [→ To Account chip, transfers only]
//   [Date chip]  [Note icon]  [Payee icon]
//
// Tapping each chip opens a focused picker (bottom sheet within sheet
// using showModalBottomSheet with a smaller fraction).
//
// This keeps the main sheet clean — all the "optional extras" live here
// without cluttering the calculator or category row.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/isar/providers/service_providers.dart';
import '../../../../core/isar/schemas/account.dart';
import '../../../../core/isar/services/account_service.dart';
import '../../../../shared/theme/app_colors.dart';
import '../quick_add_notifier.dart';

class QuickAddMetaRow extends ConsumerWidget {
  const QuickAddMetaRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickAddNotifierProvider);
    final notifier = ref.read(quickAddNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Row 1: Account(s) ─────────────────────────────────────────────
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              // From account
              _AccountChip(
                label: 'From',
                accountId: state.accountId,
                onTap: () => _showAccountPicker(
                  context,
                  ref,
                  onSelect: (id) => notifier.setAccount(id),
                  excludeId: state.toAccountId,
                ),
              ),

              // Arrow + To account (transfers only)
              if (state.isTransfer) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
                ),
                _AccountChip(
                  label: 'To',
                  accountId: state.toAccountId,
                  onTap: () => _showAccountPicker(
                    context,
                    ref,
                    onSelect: (id) => notifier.setToAccount(id),
                    excludeId: state.accountId,
                  ),
                ),
              ],

              const SizedBox(width: 10),

              // ── Date chip ──────────────────────────────────────────────
              _MetaChip(
                icon: Icons.calendar_today_outlined,
                label: _formatDate(state.transactionDate),
                onTap: () => _showDatePicker(context, ref),
              ),

              const SizedBox(width: 8),

              // ── Note chip ──────────────────────────────────────────────
              _MetaChip(
                icon: Icons.notes_rounded,
                label: state.note.isEmpty ? 'Note' : state.note,
                hasValue: state.note.isNotEmpty,
                onTap: () => _showNoteSheet(context, ref),
              ),

              const SizedBox(width: 8),

              // ── Payee chip ────────────────────────────────────────────
              _MetaChip(
                icon: Icons.person_outline_rounded,
                label: state.payee.isEmpty ? 'Payee' : state.payee,
                hasValue: state.payee.isNotEmpty,
                onTap: () => _showPayeeSheet(context, ref),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Account picker sheet ───────────────────────────────────────────────────

  void _showAccountPicker(
    BuildContext context,
    WidgetRef ref, {
    required void Function(int id) onSelect,
    int? excludeId,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AccountPickerSheet(
        onSelect: onSelect,
        excludeId: excludeId,
      ),
    );
  }

  // ── Date picker ────────────────────────────────────────────────────────────

  Future<void> _showDatePicker(BuildContext context, WidgetRef ref) async {
    final state = ref.read(quickAddNotifierProvider);
    final picked = await showDatePicker(
      context: context,
      initialDate: state.transactionDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            surface: AppColors.surfaceVariant,
            onSurface: AppColors.textPrimary,
          ),
          dialogTheme: const DialogThemeData(backgroundColor: AppColors.surface),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      ref.read(quickAddNotifierProvider.notifier).setDate(picked);
    }
  }

  // ── Note sheet ─────────────────────────────────────────────────────────────

  void _showNoteSheet(BuildContext context, WidgetRef ref) {
    final state = ref.read(quickAddNotifierProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _TextInputSheet(
        title: 'Add Note',
        initialValue: state.note,
        hint: 'e.g. Monthly groceries, Team lunch…',
        maxLength: 200,
        onSave: (val) =>
            ref.read(quickAddNotifierProvider.notifier).setNote(val),
      ),
    );
  }

  // ── Payee sheet ────────────────────────────────────────────────────────────

  void _showPayeeSheet(BuildContext context, WidgetRef ref) {
    final state = ref.read(quickAddNotifierProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _TextInputSheet(
        title: 'Payee / Merchant',
        initialValue: state.payee,
        hint: 'e.g. Swiggy, Amazon, DMart…',
        maxLength: 100,
        onSave: (val) =>
            ref.read(quickAddNotifierProvider.notifier).setPayee(val),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) return 'Today';
    if (date == yesterday) return 'Yesterday';
    return DateFormat('d MMM').format(date);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Account Chip — shows account name + colour, opens account picker
// ─────────────────────────────────────────────────────────────────────────────

class _AccountChip extends ConsumerWidget {
  final String label;
  final int? accountId;
  final VoidCallback onTap;

  const _AccountChip({
    required this.label,
    required this.accountId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balancesAsync = ref.watch(allAccountBalancesProvider);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: accountId != null
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.border,
            width: accountId != null ? 1.2 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Account colour dot
            if (accountId != null)
              balancesAsync.when(
                loading: () => const SizedBox(width: 8, height: 8),
                error: (_, __) => const SizedBox.shrink(),
                data: (balances) {
                  final ab = balances[accountId];
                  if (ab == null) return const SizedBox.shrink();
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: Color(ab.account.colorValue),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),

            Text(
              accountId != null
                  ? _accountName(balancesAsync, accountId!)
                  : label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: accountId != null
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: accountId != null
                    ? AppColors.textPrimary
                    : AppColors.textTertiary,
              ),
            ),

            const SizedBox(width: 4),
            const Icon(
              Icons.expand_more_rounded,
              size: 14,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  String _accountName(
      AsyncValue<Map<int, AccountBalance>> balancesAsync, int id) {
    return balancesAsync.when(
      loading: () => '…',
      error: (_, __) => 'Account',
      data: (b) => b[id]?.account.name ?? 'Account',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Generic Meta Chip (date / note / payee)
// ─────────────────────────────────────────────────────────────────────────────

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasValue;
  final VoidCallback onTap;

  const _MetaChip({
    required this.icon,
    required this.label,
    this.hasValue = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hasValue
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.border,
            width: hasValue ? 1.2 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: hasValue
                  ? AppColors.primary
                  : AppColors.textTertiary,
            ),
            const SizedBox(width: 5),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 80),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      hasValue ? FontWeight.w500 : FontWeight.w400,
                  color: hasValue
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Account Picker Sheet (nested modal)
// ─────────────────────────────────────────────────────────────────────────────

class _AccountPickerSheet extends ConsumerWidget {
  final void Function(int id) onSelect;
  final int? excludeId;

  const _AccountPickerSheet({
    required this.onSelect,
    this.excludeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(watchActiveAccountsProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          accountsAsync.when(
            loading: () => const CircularProgressIndicator(
                color: AppColors.primary),
            error: (_, __) => const SizedBox.shrink(),
            data: (accounts) {
              final filtered = excludeId != null
                  ? accounts.where((a) => a.id != excludeId).toList()
                  : accounts;

              return Column(
                children: filtered.map((account) {
                  final color = Color(account.colorValue);
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        IconData(account.iconCodePoint,
                            fontFamily: 'MaterialIcons'),
                        size: 18,
                        color: color,
                      ),
                    ),
                    title: Text(
                      account.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      _accountTypeLabel(account.type),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary),
                    ),
                    onTap: () {
                      onSelect(account.id);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  String _accountTypeLabel(AccountType type) {
    return switch (type) {
      AccountType.cash => 'Cash',
      AccountType.bankAccount => 'Bank Account',
      AccountType.creditCard => 'Credit Card',
      AccountType.digitalWallet => 'Digital Wallet / UPI',
      AccountType.investment => 'Investment',
      AccountType.loan => 'Loan',
      AccountType.other => 'Other',
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Text Input Sheet (note / payee)
// ─────────────────────────────────────────────────────────────────────────────

class _TextInputSheet extends StatefulWidget {
  final String title;
  final String initialValue;
  final String hint;
  final int maxLength;
  final void Function(String) onSave;

  const _TextInputSheet({
    required this.title,
    required this.initialValue,
    required this.hint,
    required this.maxLength,
    required this.onSave,
  });

  @override
  State<_TextInputSheet> createState() => _TextInputSheetState();
}

class _TextInputSheetState extends State<_TextInputSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: widget.maxLength,
            maxLines: widget.title == 'Add Note' ? 3 : 1,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: AppColors.textTertiary),
              counterStyle:
                  const TextStyle(color: AppColors.textTertiary, fontSize: 11),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                widget.onSave(_controller.text.trim());
                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}