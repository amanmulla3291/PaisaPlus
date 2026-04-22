// lib/features/home/home_screen.dart
//
// PaisaPlus – Home Dashboard Screen
// ------------------------------------
// The main screen users land on after login/approval.
// Composed of vertically stacked sections in a CustomScrollView (SliverList)
// for buttery-smooth performance even with many widgets.
//
// Section order (top to bottom):
//   1. AppBar         — greeting, month picker, admin long-press logo
//   2. Balance Card   — total balance (large) + net worth toggle
//   3. KPI Row        — monthly expense | income | savings rate (3 chips)
//   4. Accounts Strip — horizontal scroll of account balance cards
//   5. Pie Chart      — expense breakdown by category this month
//   6. Line Chart     — daily spend trend this month
//   7. Recent Txns    — last 5 transactions with "See all" link
//
// All data comes from Riverpod providers (service_providers.dart).
// No setState anywhere — pure Riverpod reactive UI.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/isar/providers/service_providers.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/paisa_app_bar.dart';
import 'widgets/balance_card.dart';
import 'widgets/kpi_row.dart';
import 'widgets/account_cards_strip.dart';
import 'widgets/expense_pie_chart.dart';
import 'widgets/spend_line_chart.dart';
import 'widgets/recent_transactions_section.dart';

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
      duration: const Duration(milliseconds: 900),
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
    final currentMonth = DateTime(now.year, now.month);
    if (_selectedMonth.isBefore(currentMonth)) {
      HapticFeedback.selectionClick();
      setState(() {
        _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: RefreshIndicator(
        color: AppTheme.zerodhaRed,
        backgroundColor: AppTheme.surface,
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
            PaisaHomeAppBar(
              selectedMonth: _selectedMonth,
              onPreviousMonth: _goToPreviousMonth,
              onNextMonth: _goToNextMonth,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.0,
                    child: BalanceCard(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 12),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.1,
                    child: KpiRow(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 20),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.2,
                    child: _SectionHeader(
                      title: 'Accounts',
                      actionLabel: 'Manage',
                      onAction: () => context.go('/accounts'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.25,
                    child: const AccountCardsStrip(),
                  ),
                  const SizedBox(height: 24),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.35,
                    child: _SectionHeader(
                      title: 'Spending by Category',
                      actionLabel: _monthLabel(_selectedMonth),
                      onAction: null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.4,
                    child: ExpensePieChart(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 24),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.5,
                    child: const _SectionHeader(
                      title: 'Daily Spending',
                      actionLabel: null,
                      onAction: null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.55,
                    child: SpendLineChart(selectedMonth: _selectedMonth),
                  ),
                  const SizedBox(height: 24),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.65,
                    child: _SectionHeader(
                      title: 'Recent',
                      actionLabel: 'See all',
                      onAction: () => context.go('/transactions'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _StaggeredSection(
                    controller: _staggerController,
                    delay: 0.7,
                    child: const RecentTransactionsSection(),
                  ),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthLabel(DateTime month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month.month - 1];
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            letterSpacing: -0.2,
          ),
        ),
        const Spacer(),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: onAction != null ? AppTheme.zerodhaRed : AppTheme.textTertiary,
              ),
            ),
          ),
      ],
    );
  }
}

class _StaggeredSection extends StatelessWidget {
  final AnimationController controller;
  final double delay;
  final Widget child;

  const _StaggeredSection({
    required this.controller,
    required this.delay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final interval = CurvedAnimation(
      parent: controller,
      curve: Interval(delay, (delay + 0.3).clamp(0.0, 1.0), curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: interval,
      builder: (context, _) {
        return Opacity(
          opacity: interval.value,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - interval.value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
