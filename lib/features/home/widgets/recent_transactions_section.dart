// lib/features/home/widgets/recent_transactions_section.dart
//
// PaisaPlus – Recent Transactions Section
// -----------------------------------------
// Shows the last 5 transactions as compact list tiles on the home screen.
// Each tile: category icon chip | payee/note | date | amount (coloured)
//
// Tapping a tile opens the transaction detail sheet (Phase 3).
// Empty state: illustration + "Add your first expense" prompt.
//
// Intentionally not paginated here — this is a preview. Full list is on
// the Transactions tab.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/schemas/transaction.dart';
import '../../../core/isar/services/category_service.dart';
import '../../../shared/theme/app_colors.dart';

class RecentTransactionsSection extends ConsumerWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnAsync = ref.watch(watchRecentTransactionsProvider);

    return txnAsync.when(
      loading: () => _shimmerList(),
      error: (_, __) => const SizedBox.shrink(),
      data: (txns) {
        final recent = txns.take(5).toList();

        if (recent.isEmpty) {
          return const _EmptyTransactions();
        }

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recent.length,
            separatorBuilder: (_, __) => const Divider(
              height: 0.5,
              thickness: 0.5,
              indent: 56,
              endIndent: 0,
            ),
            itemBuilder: (context, index) {
              return _TransactionTile(
                transaction: recent[index],
                catService: ref.watch(categoryServiceProvider),
              );
            },
          ),
        );
      },
    );
  }

  Widget _shimmerList() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Transaction Tile
// ─────────────────────────────────────────────────────────────────────────────

class _TransactionTile extends StatefulWidget {
  final Transaction transaction;
  final AsyncValue<CategoryService> catService;

  const _TransactionTile({
    required this.transaction,
    required this.catService,
  });

  @override
  State<_TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<_TransactionTile> {
  String _catName = '';
  int _catColor = 0xFF9E9E9E;
  int _catIcon = Icons.circle.codePoint;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  Future<void> _loadCategory() async {
    widget.catService.whenData((svc) async {
      final cat = await svc.getById(widget.transaction.categoryId);
      if (mounted) {
        setState(() {
          _catName = cat?.name ?? 'Unknown';
          _catColor = cat?.colorValue ?? 0xFF9E9E9E;
          _catIcon = cat?.iconCodePoint ?? Icons.circle.codePoint;
          _loaded = true;
        });
      }
    });
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
    final catColor = Color(_catColor);
    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    final rupees = txn.amountInPaise / 100.0;

    return GestureDetector(
      onTap: () {
        // Transaction detail sheet — built in Phase 3.
        // Route: /transactions/:id  (registered in app_router.dart)
        context.push('/transactions/${txn.id}');
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // ── Category icon chip ────────────────────────────────────────
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: catColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _loaded
                  ? Icon(
                      IconData(_catIcon, fontFamily: 'MaterialIcons'),
                      size: 18,
                      color: catColor,
                    )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(width: 12),

            // ── Title + subtitle ──────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txn.payee?.isNotEmpty == true ? txn.payee! : _catName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _buildSubtitle(txn),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // ── Amount ────────────────────────────────────────────────────
            Text(
              '$sign ₹${formatter.format(rupees)}',
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
    );
  }

  String _buildSubtitle(Transaction txn) {
    final parts = <String>[];

    // Note
    if (txn.note?.isNotEmpty == true) parts.add(txn.note!);

    // Date
    final now = DateTime.now();
    final date = txn.transactionDate;
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      parts.add('Today');
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      parts.add('Yesterday');
    } else {
      parts.add(DateFormat('d MMM').format(date));
    }

    return parts.join(' · ');
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty State
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 44,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 12),
          const Text(
            'No transactions yet',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tap the + button to add your first expense',
            style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              // Trigger the QuickAddSheet — the same sheet the red FAB opens.
              // Dispatched via a Riverpod notifier so the FAB and this button
              // share a single source of truth for sheet visibility.
              // Wired in Step 4 (QuickAddSheet) via quickAddSheetProvider.
              context.push('/add-transaction');
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 0.5,
                ),
              ),
              child: const Text(
                'Add Expense',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}