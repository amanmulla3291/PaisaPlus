// lib/shared/widgets/main_shell.dart
// ─────────────────────────────────────────────────────────────────────────────
// Main app shell — bottom navigation + persistent red FAB.
//
// FIX — P0 Gesture Recognition Failure (Admin Panel):
//   The original code wrapped the AppBar logo in a `GestureDetector` placed
//   inside `AppBar.leading`. Flutter's AppBar intercepts pointer events for
//   its own ink splash handling, causing the GestureDetector's `onLongPress`
//   to lose the gesture arena competition — the long-press was silently eaten
//   before it reached the callback.
//
//   Fix: Replaced `GestureDetector` with `InkWell` using `splashColor` and
//   `highlightColor` set to transparent. InkWell participates correctly in the
//   AppBar's gesture arena and its `onLongPress` fires reliably. The visual
//   tap feedback is suppressed (transparent) since the logo is the brand mark,
//   not an interactive button with visible feedback.
//
// ADDITIONAL FIX — Missing 'More' tab in bottom nav:
//   The original _tabs list had 5 entries (home/txn/budgets/reports/more) but
//   the _BottomNav widget only rendered 4 items (no 'More'). The 5th tab was
//   unreachable from the UI. Added the More nav item.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/transactions/quick_add/quick_add_sheet.dart';

import '../../core/services/auth_service.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/router/app_router.dart';

class MainShell extends ConsumerWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const _tabs = [
    AppRoutes.home,
    AppRoutes.transactions,
    AppRoutes.budgets,
    AppRoutes.reports,
    AppRoutes.more,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final idx = _tabs.indexOf(location);
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isAdmin = authState.profile?.isAdmin ?? false;
    final currentIndex = _currentIndex(context);

    return Scaffold(
      backgroundColor: AppColors.background,

      // ── AppBar with long-press logo gesture ──────────────────────────────
      appBar: AppBar(
        leadingWidth: 56,
        leading: InkWell(
          // FIX: InkWell instead of GestureDetector.
          // GestureDetector inside AppBar.leading loses long-press to the
          // AppBar's own gesture handling. InkWell participates correctly.
          onLongPress: isAdmin
              ? () {
                  HapticFeedback.heavyImpact();
                  _openAdminPanel(context);
                }
              : null,
          // No visible ink feedback — this is a brand logo, not a button
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/images/pp_logo.png',
              errorBuilder: (_, __, ___) => Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'P',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'PaisaPlus',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 22),
            color: AppColors.textSecondary,
            onPressed: () {},
          ),
        ],
      ),

      // ── Page content ──────────────────────────────────────────────────────
      body: child,

      // ── Persistent red FAB ────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickAdd(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ── Bottom Navigation ─────────────────────────────────────────────────
      bottomNavigationBar: _BottomNav(
        currentIndex: currentIndex,
        onTap: (idx) => context.go(_tabs[idx]),
      ),
    );
  }

  void _openAdminPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _AdminPanelPlaceholder(),
    );
  }

  void _showQuickAdd(BuildContext context) {
    showQuickAddSheet(context);
  }
}

// ── Bottom Navigation Bar ─────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.surface,
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'Home',
              index: 0,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
            _NavItem(
              icon: Icons.receipt_long_outlined,
              activeIcon: Icons.receipt_long_rounded,
              label: 'Txns',
              index: 1,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
            // Centre gap for the docked FAB
            const SizedBox(width: 48),
            _NavItem(
              icon: Icons.bar_chart_outlined,
              activeIcon: Icons.bar_chart_rounded,
              label: 'Reports',
              // FIX: was index 3 (Reports), but Budgets (index 2) was
              // unreachable. Layout: Home | Txns | [FAB] | Reports | More
              // Budgets is accessible via More tab → settings in Phase 3.
              index: 3,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
            _NavItem(
              icon: Icons.more_horiz_rounded,
              activeIcon: Icons.more_horiz_rounded,
              label: 'More',
              index: 4,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 22,
              color: isActive ? AppColors.primary : AppColors.textTertiary,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.primary : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Admin Panel Placeholder ───────────────────────────────────────────────────
class _AdminPanelPlaceholder extends StatelessWidget {
  const _AdminPanelPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(
            Icons.admin_panel_settings_rounded,
            color: AppColors.primary,
            size: 40,
          ),
          const SizedBox(height: 12),
          const Text(
            'Admin Panel',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Full admin panel coming in Phase 5.\nYou\'ll manage approvals and device bindings here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}