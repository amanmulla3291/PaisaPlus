// lib/features/home/home_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// Phase 2 Home Dashboard — replaces the "Coming in Phase 2" stub.
// Imports all Phase 2 home widgets.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/isar/providers/service_providers.dart';
import '../../shared/theme/app_colors.dart';
import 'widgets/balance_card.dart';
import 'widgets/kpi_row.dart';
import 'widgets/account_cards_strip.dart';
import 'widgets/expense_pie_chart.dart';
import 'widgets/spend_line_chart.dart';
import 'widgets/recent_transactions_section.dart';
import 'widgets/phase3_insights.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late DateTime _selectedMonth;
  late AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month);

    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _staggerController.forward();
    });
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
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
      // The AppBar is provided by MainShell — HomeScreen only provides body
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        onRefresh: () async {
          ref.invalidate(netWorthInPaiseProvider);
          ref.invalidate(allAccountBalancesProvider);
          ref.invalidate(monthlyExpenseInPaiseProvider(_selectedMonth));
          ref.invalidate(monthlyIncomeInPaiseProvider(_selectedMonth));
          ref.invalidate(monthlyExpensesByCategoryProvider(_selectedMonth));
          ref.invalidate(dailyExpenseTotalsProvider(_selectedMonth));
          await Future.delayed(const Duration(milliseconds: 400));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // Month navigator
            SliverToBoxAdapter(
              child: _MonthNav(
                selectedMonth: _selectedMonth,
                onPrevious: _goToPreviousMonth,
                onNext: _goToNextMonth,
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Balance card
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.0,
                    child: BalanceCard(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 12),

                  // KPI row
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.1,
                    child: KpiRow(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 12),

                  // Phase 3 Insights (Budgets, Loans, Bills)
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.15,
                    child: HomePhase3Insights(month: _selectedMonth),
                  ),
                  const SizedBox(height: 20),

                  // Accounts
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.2,
                    child: const _SectionHeader(title: 'Accounts'),
                  ),
                  const SizedBox(height: 10),
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.25,
                    child: const AccountCardsStrip(),
                  ),
                  const SizedBox(height: 24),

                  // Spending pie chart
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.35,
                    child: const _SectionHeader(title: 'Spending by Category'),
                  ),
                  const SizedBox(height: 10),
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.4,
                    child: ExpensePieChart(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 24),

                  // Daily line chart
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.5,
                    child: const _SectionHeader(title: 'Daily Spending'),
                  ),
                  const SizedBox(height: 10),
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.55,
                    child: SpendLineChart(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 24),

                  // Recent transactions
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.65,
                    child: const _SectionHeader(title: 'Recent'),
                  ),
                  const SizedBox(height: 10),
                  _Staggered(
                    controller: _staggerController,
                    delay: 0.7,
                    child: const RecentTransactionsSection(),
                  ),

                  // Padding for FAB
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Month Navigator bar ───────────────────────────────────────────────────────

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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPrevious,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.chevron_left_rounded,
                  size: 20, color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: isCurrentMonth ? null : onNext,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(Icons.chevron_right_rounded,
                  size: 20,
                  color: isCurrentMonth
                      ? AppColors.textTertiary
                      : AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      ),
    );
  }
}

// ── Stagger animation wrapper ─────────────────────────────────────────────────

class _Staggered extends StatelessWidget {
  final AnimationController controller;
  final double delay;
  final Widget child;

  const _Staggered({
    required this.controller,
    required this.delay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(
      parent: controller,
      curve: Interval(delay, (delay + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) => Opacity(
        opacity: anim.value,
        child: Transform.translate(
          offset: Offset(0, 16 * (1 - anim.value)),
          child: child,
        ),
      ),
    );
  }
}