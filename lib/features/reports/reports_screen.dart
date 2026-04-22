// lib/features/reports/reports_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// Reports Dashboard — analytics and visualizations.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/theme/app_colors.dart';
import 'widgets/category_pie_chart.dart';
import 'widgets/cash_flow_line_chart.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month);
  }

  void _goToPreviousMonth() {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    final now = DateTime.now();
    if (_selectedMonth.isBefore(DateTime(now.year, now.month))) {
      HapticFeedback.selectionClick();
      setState(() {
        _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ─────────────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            pinned: true,
            title: const Text(
              'Analytics',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: AppColors.textPrimary,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: _MonthNav(
                selectedMonth: _selectedMonth,
                onPrevious: _goToPreviousMonth,
                onNext: _goToNextMonth,
              ),
            ),
          ),

          // ── Charts ─────────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 1. Cash Flow Trend
                CashFlowLineChart(month: _selectedMonth),
                const SizedBox(height: 24),

                // 2. Category Pie
                CategoryPieChart(month: _selectedMonth),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable Month Navigator ────────────────────────────────────────────────
class _MonthNav extends StatelessWidget {
  final DateTime selectedMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _MonthNav({
    required this.selectedMonth,
    required this.onPrevious,
    required this.onNext,
  });

  static const _months = [
    'Jan','Feb','Mar','Apr','May','Jun',
    'Jul','Aug','Sep','Oct','Nov','Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentMonth =
        selectedMonth.year == now.year && selectedMonth.month == now.month;
    final label =
        '${_months[selectedMonth.month - 1]} ${selectedMonth.year}';

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded, size: 20),
            onPressed: onPrevious,
            color: AppColors.textSecondary,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded, size: 20),
            onPressed: isCurrentMonth ? null : onNext,
            color: isCurrentMonth ? AppColors.textTertiary : AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
