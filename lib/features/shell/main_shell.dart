// lib/features/shell/main_shell.dart
//
// PaisaPlus – Main App Shell
// ----------------------------
// The persistent scaffold that wraps all 5 bottom-nav tabs.
// Provides:
//   • Bottom navigation bar (Home | Transactions | Budgets | Reports | More)
//   • Persistent red FAB (always visible, always centred above nav bar)
//   • FAB opens QuickAddSheet via showQuickAddSheet()
//
// Navigation:
//   GoRouter's ShellRoute drives tab switching. Each tab is a separate
//   GoRouter branch so back-stack is preserved per tab (tapping Home while
//   on Reports returns to wherever Home was, not root).
//
// FAB behaviour:
//   • Always red (AppTheme.zerodhaRed)
//   • Persists across ALL tabs — even Budgets, Reports, More
//   • Animates with a subtle scale-bounce on tap before opening sheet
//   • floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
//     with BottomAppBar notch — matching Kite-style centre dock layout.
//
// Shell is a StatefulWidget because it holds the current tab index and
// manages the FAB animation controller. No Riverpod needed here — this
// is pure navigation state.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme/app_theme.dart';
import '../transactions/quick_add/quick_add_sheet.dart';

class MainShell extends StatefulWidget {
  /// The child widget is provided by GoRouter's ShellRoute.
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  // FAB bounce animation on tap
  late AnimationController _fabController;
  late Animation<double> _fabScale;

  // Tab definitions — order must match GoRouter branch order
  static const _tabs = [
    _TabItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
      route: '/home',
    ),
    _TabItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long_rounded,
      label: 'Transactions',
      route: '/transactions',
    ),
    _TabItem(
      icon: Icons.donut_large_outlined,
      activeIcon: Icons.donut_large_rounded,
      label: 'Budgets',
      route: '/budgets',
    ),
    _TabItem(
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart_rounded,
      label: 'Reports',
      route: '/reports',
    ),
    _TabItem(
      icon: Icons.more_horiz_rounded,
      activeIcon: Icons.more_horiz_rounded,
      label: 'More',
      route: '/more',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.88,
      upperBound: 1.0,
      value: 1.0,
    );
    _fabScale = _fabController;
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) {
      // Already on this tab — pop to root of this branch
      context.go(_tabs[index].route);
      return;
    }
    HapticFeedback.selectionClick();
    setState(() => _currentIndex = index);
    context.go(_tabs[index].route);
  }

  Future<void> _onFabTapped() async {
    HapticFeedback.mediumImpact();
    await _fabController.reverse();
    await _fabController.forward();
    if (!mounted) return;
    showQuickAddSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      extendBody: true, // content goes behind the bottom nav bar
      body: widget.child,

      // ── Bottom Nav Bar ─────────────────────────────────────────────────
      bottomNavigationBar: _PaisaBottomNav(
        currentIndex: _currentIndex,
        tabs: _tabs,
        onTap: _onTabTapped,
      ),

      // ── Persistent FAB ─────────────────────────────────────────────────
      floatingActionButton: ScaleTransition(
        scale: _fabScale,
        child: FloatingActionButton(
          onPressed: _onFabTapped,
          backgroundColor: AppTheme.zerodhaRed,
          foregroundColor: Colors.white,
          elevation: 6,
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded, size: 28),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom Navigation Bar
// Custom implementation for full control over active indicator style.
// ─────────────────────────────────────────────────────────────────────────────

class _PaisaBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_TabItem> tabs;
  final void Function(int) onTap;

  const _PaisaBottomNav({
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64 + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(color: AppTheme.divider, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Left 2 tabs
            ...List.generate(2, (i) => _NavItem(
                  tab: tabs[i],
                  isSelected: currentIndex == i,
                  onTap: () => onTap(i),
                )),

            // Centre gap for the FAB
            const Expanded(child: SizedBox()),

            // Right 2 tabs
            ...List.generate(2, (i) => _NavItem(
                  tab: tabs[i + 3],
                  isSelected: currentIndex == i + 3,
                  onTap: () => onTap(i + 3),
                )),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final _TabItem tab;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: child,
              ),
              child: Icon(
                isSelected ? tab.activeIcon : tab.icon,
                key: ValueKey(isSelected),
                size: 22,
                color: isSelected
                    ? AppTheme.zerodhaRed
                    : AppTheme.textTertiary,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppTheme.zerodhaRed
                    : AppTheme.textTertiary,
                letterSpacing: 0.1,
              ),
            ),
            // Active indicator dot
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 16 : 0,
              height: isSelected ? 2 : 0,
              decoration: BoxDecoration(
                color: AppTheme.zerodhaRed,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data class
// ─────────────────────────────────────────────────────────────────────────────

class _TabItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const _TabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}
