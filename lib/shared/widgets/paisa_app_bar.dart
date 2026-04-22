// lib/shared/widgets/paisa_app_bar.dart
//
// PaisaPlus – Home AppBar (SliverAppBar)
// ----------------------------------------
// Features:
//  • Left:   App logo — long-press opens AdminPanel if is_admin == true
//  • Centre: Month navigator  ← April 2026 →
//  • Right:  Backup reminder bell + Google profile avatar
//
// ── Phase 1 merge checklist (3 steps, zero guesswork) ─────────────────────
// When Phase 1 auth is merged, do exactly these three things:
//
//   1. Uncomment the two imports at the top of this file.
//   2. In PaisaHomeAppBar.build(): delete `const isAdmin = false;` and
//      uncomment the two lines below it.
//   3. In _ProfileAvatar.build(): delete `const String? photoUrl = null;`
//      and uncomment the two lines above it.
//
// All routes (/admin, /backup, /settings) are already wired to GoRouter.
// ──────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

import '../../features/admin/admin_panel_sheet.dart';
import '../../core/services/auth_service.dart';

class PaisaHomeAppBar extends ConsumerWidget {
  final DateTime selectedMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const PaisaHomeAppBar({
    super.key,
    required this.selectedMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(authProvider).profile;
    final isAdmin = profile?.isAdmin ?? false;

    final now = DateTime.now();
    final isCurrentMonth =
        selectedMonth.year == now.year && selectedMonth.month == now.month;

    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: AppTheme.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 60,
      leading: const _AdminLogo(isAdmin: isAdmin),
      title: _MonthNavigator(
        selectedMonth: selectedMonth,
        isCurrentMonth: isCurrentMonth,
        onPrevious: onPreviousMonth,
        onNext: onNextMonth,
      ),
      centerTitle: true,
      actions: const [
        _NotificationButton(),
        SizedBox(width: 8),
        _ProfileAvatar(),
        SizedBox(width: 16),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0.5),
        child: Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Admin Logo — long-press opens /admin route (Phase 5 AdminPanelSheet)
// The gesture is always registered but _handleLongPress is a no-op for
// non-admin users, so there is no visual affordance that the gesture exists.
// ─────────────────────────────────────────────────────────────────────────────

class _AdminLogo extends StatefulWidget {
  final bool isAdmin;
  const _AdminLogo({required this.isAdmin});

  @override
  State<_AdminLogo> createState() => _AdminLogoState();
}

class _AdminLogoState extends State<_AdminLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.85,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleLongPress(BuildContext context) {
    if (!widget.isAdmin) return;
    HapticFeedback.heavyImpact();
    AdminPanelSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => _handleLongPress(context),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      onTapDown: (_) => _pulseController.reverse(),
      onTapUp: (_) => _pulseController.forward(),
      onTapCancel: () => _pulseController.forward(),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (_, child) =>
            Transform.scale(scale: _pulseController.value, child: child),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.zerodhaRed,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'P₹',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Month Navigator
// ─────────────────────────────────────────────────────────────────────────────

class _MonthNavigator extends StatelessWidget {
  final DateTime selectedMonth;
  final bool isCurrentMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _MonthNavigator({
    required this.selectedMonth,
    required this.isCurrentMonth,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final label = DateFormat('MMMM yyyy').format(selectedMonth);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ArrowButton(icon: Icons.chevron_left_rounded, onTap: onPrevious),
        const SizedBox(width: 4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            label,
            key: ValueKey(label),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ),
        const SizedBox(width: 4),
        _ArrowButton(
          icon: Icons.chevron_right_rounded,
          onTap: isCurrentMonth ? null : onNext,
          disabled: isCurrentMonth,
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool disabled;

  const _ArrowButton({required this.icon, this.onTap, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 20,
          color: disabled ? AppTheme.textTertiary : AppTheme.textSecondary,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Notification / Backup Reminder Bell
// Navigates to /backup (Phase 5 — Local Backup screen).
// A red badge dot will be injected here in Phase 5 when
// BackupReminderProvider detects the user is overdue for a backup.
// ─────────────────────────────────────────────────────────────────────────────

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/backup'),
      child: const Icon(
        Icons.notifications_outlined,
        size: 22,
        color: AppTheme.textSecondary,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile Avatar
// Shows user's Google photo when available; falls back to outline icon.
// Taps open /settings (built in Phase 5).
//
// Phase 1 merge: delete `const String? photoUrl = null;` and uncomment
// the two lines above it.
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileAvatar extends ConsumerWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(authProvider).profile;
    final String? photoUrl = profile?.photoUrl;

    return GestureDetector(
      onTap: () => context.push('/settings'),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.surface,
          border: Border.all(color: AppTheme.divider, width: 1),
        ),
        child: ClipOval(
          child: photoUrl != null
              ? Image.network(
                  photoUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const _DefaultAvatar(),
                )
              : const _DefaultAvatar(),
        ),
      ),
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.person_outline_rounded,
      size: 16,
      color: AppTheme.textSecondary,
    );
  }
}
