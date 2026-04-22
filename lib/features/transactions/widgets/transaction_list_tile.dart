// lib/features/transactions/widgets/transaction_list_tile.dart
//
// PaisaPlus – Transaction List Tile
// -----------------------------------
// The reusable tile used in both the Transactions list screen and anywhere
// else a transaction row appears (search results, account detail, etc.).
//
// Layout:
//   [Category icon]  [Payee/Category · Note]  [Date]  [±Amount]
//                    [Account chip]
//
// Swipe actions (Dismissible):
//   Left swipe  → soft-delete (red trash icon)
//   Right swipe → edit (blue edit icon) — Phase 3 route stub
//
// Long press → context menu (Delete | Edit | Copy Amount | View Detail)
//
// All destructive actions go through TransactionService.softDelete() which
// uses Isar writeTxn and triggers the Riverpod stream, causing the list to
// reactively update without manual setState.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/schemas/account.dart';
import '../../../core/isar/schemas/category.dart';
import '../../../core/isar/schemas/transaction.dart';
import '../../../shared/theme/app_colors.dart';

class TransactionListTile extends ConsumerStatefulWidget {
  final Transaction transaction;

  /// Called after a soft-delete so the parent list can remove the item
  /// from its local copy without waiting for the stream to rebuild.
  final VoidCallback? onDeleted;

  const TransactionListTile({
    super.key,
    required this.transaction,
    this.onDeleted,
  });

  @override
  ConsumerState<TransactionListTile> createState() =>
      _TransactionListTileState();
}

class _TransactionListTileState extends ConsumerState<TransactionListTile> {
  Category? _category;
  Account? _account;
  bool _metaLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadMeta();
  }

  @override
  void didUpdateWidget(TransactionListTile old) {
    super.didUpdateWidget(old);
    if (old.transaction.id != widget.transaction.id) {
      _loadMeta();
    }
  }

  Future<void> _loadMeta() async {
    final catService = await ref.read(categoryServiceProvider.future);
    final accountService = await ref.read(accountServiceProvider.future);

    final cat = await catService.getById(widget.transaction.categoryId);
    final acc = await accountService.getById(widget.transaction.accountId);

    if (mounted) {
      setState(() {
        _category = cat;
        _account = acc;
        _metaLoaded = true;
      });
    }
  }

  Future<void> _handleDelete() async {
    final txn = widget.transaction;
    final service = await ref.read(transactionServiceProvider.future);

    HapticFeedback.mediumImpact();

    if (txn.type == TransactionType.transfer &&
        txn.transferPairId != null) {
      await service.softDeleteTransferPair(txn.transferPairId!);
    } else {
      await service.softDelete(txn.id);
    }

    widget.onDeleted?.call();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Transaction deleted'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          action: SnackBarAction(
            label: 'Undo',
            textColor: AppColors.primary,
            onPressed: () async {
              final s = await ref.read(transactionServiceProvider.future);
              await s.restore(txn.id);
            },
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _showContextMenu(BuildContext context) {
    final txn = widget.transaction;
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.open_in_new_rounded,
                  color: AppColors.textSecondary),
              title: const Text('View Details'),
              onTap: () {
                Navigator.pop(context);
                context.push('/transactions/${txn.id}');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined,
                  color: AppColors.textSecondary),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                // Edit sheet — Phase 3
                context.push('/transactions/${txn.id}/edit');
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy_outlined,
                  color: AppColors.textSecondary),
              title: const Text('Copy Amount'),
              onTap: () {
                Navigator.pop(context);
                final rupees = txn.amountInPaise / 100.0;
                Clipboard.setData(
                    ClipboardData(text: rupees.toStringAsFixed(2)));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Amount copied'),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            const Divider(height: 0.5, thickness: 0.5),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded,
                  color: AppColors.primary),
              title: const Text(
                'Delete',
                style: TextStyle(color: AppColors.primary),
              ),
              onTap: () {
                Navigator.pop(context);
                _handleDelete();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final txn = widget.transaction;
    final isExpense = txn.type == TransactionType.expense;
    final isTransfer = txn.type == TransactionType.transfer;

    final amountColor = isExpense
        ? AppColors.primary
        : isTransfer
            ? AppColors.textSecondary
            : AppColors.income;

    final sign = isExpense ? '−' : isTransfer ? '↔' : '+';
    final catColor =
        _category != null ? Color(_category!.colorValue) : AppColors.textTertiary;
    final rupees = txn.amountInPaise / 100.0;
    final isPrivate = ref.watch(privacyModeProvider);
    final amountStr = isPrivate
        ? '$sign ₹••••'
        : '$sign ₹${NumberFormat('#,##,##0.00', 'en_IN').format(rupees)}';

    return Dismissible(
      key: ValueKey(txn.id),
      // Left → delete
      background: const _SwipeBackground(
        color: AppColors.error,
        icon: Icons.delete_outline_rounded,
        alignment: Alignment.centerLeft,
      ),
      // Right → edit
      secondaryBackground: const _SwipeBackground(
        color: Color(0xFF1565C0),
        icon: Icons.edit_outlined,
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Delete
          await _handleDelete();
          return true;
        } else {
          // Edit — don't actually dismiss, just navigate
          context.push('/transactions/${txn.id}/edit');
          return false;
        }
      },
      child: GestureDetector(
        onLongPress: () => _showContextMenu(context),
        onTap: () => context.push('/transactions/${txn.id}'),
        child: Container(
          color: Colors.transparent,
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Row(
            children: [
              // ── Category icon ───────────────────────────────────────────
              _CategoryIcon(
                category: _category,
                color: catColor,
                loaded: _metaLoaded,
              ),

              const SizedBox(width: 12),

              // ── Title + meta ────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row: payee (or category) + date
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            txn.payee?.isNotEmpty == true
                                ? txn.payee!
                                : _category?.name ?? '—',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _dateLabel(txn.transactionDate),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    // Subtitle row: account chip + note
                    Row(
                      children: [
                        if (_account != null)
                          _AccountChip(account: _account!),
                        if (_account != null &&
                            txn.note?.isNotEmpty == true)
                          const SizedBox(width: 6),
                        if (txn.note?.isNotEmpty == true)
                          Expanded(
                            child: Text(
                              txn.note!,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // ── Amount ──────────────────────────────────────────────────
              Text(
                amountStr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);
    final diff = today.difference(d).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (date.year == now.year) return DateFormat('d MMM').format(date);
    return DateFormat('d MMM yy').format(date);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryIcon extends StatelessWidget {
  final Category? category;
  final Color color;
  final bool loaded;

  const _CategoryIcon({
    required this.category,
    required this.color,
    required this.loaded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: loaded ? color.withValues(alpha: 0.13) : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: loaded && category != null
          ? Icon(
              IconData(category!.iconCodePoint, fontFamily: 'MaterialIcons'),
              size: 19,
              color: color,
            )
          : null,
    );
  }
}

class _AccountChip extends StatelessWidget {
  final Account account;
  const _AccountChip({required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Color(account.colorValue).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        account.name,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(account.colorValue),
        ),
      ),
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Alignment alignment;

  const _SwipeBackground({
    required this.color,
    required this.icon,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}