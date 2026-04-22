// lib/shared/router/app_router.dart
// ─────────────────────────────────────────────────────────────────────────────
// GoRouter config for PaisaPlus.
//
// FIX — P0 UI/Navigation Lag:
//   The original code called `ref.watch(authProvider)` inside a plain
//   `Provider<GoRouter>`, which caused a brand-new GoRouter to be constructed
//   on every auth state change. Because `app.dart` feeds this into
//   `MaterialApp.router(routerConfig: router)`, every reconstruction tore down
//   and rebuilt the ENTIRE widget tree — causing the frame drops, navigation
//   lag, and unresponsive behaviour reported.
//
//   Fix: GoRouter is now created EXACTLY ONCE via `ref.read`. Auth state
//   changes are communicated to GoRouter through `refreshListenable`
//   (_AuthChangeNotifier), which triggers redirect re-evaluation without
//   rebuilding the router or the widget tree.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/auth_service.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/sign_in_screen.dart';
import '../../features/auth/pending_screen.dart';
import '../../features/auth/device_mismatch_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/transactions/transactions_screen.dart';
import '../../features/budgets/budgets_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/more/more_screen.dart';
import '../../features/goals/goals_screen.dart';
import '../../features/loans/loans_screen.dart';
import '../../features/recurring/recurring_screen.dart';
import '../../features/subscriptions/subscriptions_screen.dart';
import '../../features/security/security_screen.dart';
import '../../features/more/backup_screen.dart';
import '../../features/accounts/accounts_screen.dart';
import '../../features/accounts/account_detail_screen.dart';
import '../../features/accounts/widgets/account_form_sheet.dart';
import '../widgets/main_shell.dart';

// ── Route paths ───────────────────────────────────────────────────────────────
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String pending = '/pending';
  static const String deviceMismatch = '/device-mismatch';
  static const String home = '/home';
  static const String transactions = '/transactions';
  static const String budgets = '/budgets';
  static const String reports = '/reports';
  static const String more = '/more';
  static const String goals = '/goals';
  static const String loans = '/loans';
  static const String automations = '/automations';
  static const String subscriptions = '/subscriptions';
  static const String security = '/security';
  static const String accounts = '/accounts';
  static const String addAccount = '/accounts/add';
  static String accountDetail(int id) => '/accounts/$id';
  static const String backup = '/backup';
}

// ── Auth change notifier ──────────────────────────────────────────────────────
// A thin ChangeNotifier that listens to authProvider and fires whenever
// auth state changes. GoRouter uses this via refreshListenable to re-run
// its redirect function without recreating the router.
class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    // Listen — fires notifyListeners() on every authProvider state change.
    // This is the ONLY thing that needs to happen when auth changes:
    // GoRouter re-evaluates redirect, nothing else rebuilds.
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

// ── Router provider ───────────────────────────────────────────────────────────
// keepAlive: true is implicit for Provider — this router lives for the
// entire app lifetime. Never recreated.
final appRouterProvider = Provider<GoRouter>((ref) {
  // ref.read — intentionally NOT watch. The router is created once.
  // _AuthChangeNotifier handles re-running redirect via refreshListenable.
  final authChangeNotifier = _AuthChangeNotifier(ref);

  // Ensure the notifier is disposed when the provider is disposed.
  ref.onDispose(authChangeNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,

    // refreshListenable re-evaluates redirect() whenever auth state changes,
    // without rebuilding the router or the widget tree.
    refreshListenable: authChangeNotifier,

    redirect: (context, state) {
      // ref.read here — this runs inside GoRouter's redirect callback,
      // not inside a widget build. Reading (not watching) is correct.
      final authState = ref.read(authProvider);
      final path = state.matchedLocation;

      switch (authState.status) {
        case AuthStatus.initial:
        case AuthStatus.loading:
          // Stay on current route while loading — don't redirect
          return null;

        case AuthStatus.unauthenticated:
          if (path == AppRoutes.onboarding || path == AppRoutes.signIn) {
            return null;
          }
          return AppRoutes.signIn;

        case AuthStatus.pendingApproval:
          if (path == AppRoutes.pending) return null;
          return AppRoutes.pending;

        case AuthStatus.deviceMismatch:
          if (path == AppRoutes.deviceMismatch) return null;
          return AppRoutes.deviceMismatch;

        case AuthStatus.authenticated:
          // Prevent navigating back to auth screens after successful login
          if (path == AppRoutes.signIn ||
              path == AppRoutes.onboarding ||
              path == AppRoutes.pending ||
              path == AppRoutes.splash) {
            return AppRoutes.home;
          }
          return null;

        case AuthStatus.error:
          return AppRoutes.signIn;
      }
    },

    routes: [
      // ── Splash / entry point ────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const _SplashRedirect(),
      ),

      // ── Onboarding ──────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: OnboardingScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // ── Sign In ─────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.signIn,
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: SignInScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // ── Pending approval ────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.pending,
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: PendingScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // ── Device mismatch ─────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.deviceMismatch,
        pageBuilder: (context, state) => const CustomTransitionPage(
          child: DeviceMismatchScreen(),
          transitionsBuilder: _fadeTransition,
        ),
      ),

      // ── Main app shell (bottom nav + FAB) ───────────────────────────────
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.transactions,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TransactionsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.budgets,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BudgetsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.reports,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ReportsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.more,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MoreScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.goals,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: GoalsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.loans,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LoansScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.automations,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: RecurringScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.subscriptions,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SubscriptionsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.security,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SecurityScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.accounts,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.backup,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BackupScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.addAccount,
            pageBuilder: (context, state) => CustomTransitionPage(
              fullscreenDialog: true,
              opaque: false,
              barrierColor: Colors.black54,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: animation.drive(
                    Tween(begin: const Offset(0, 1), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeOutCubic)),
                  ),
                  child: child,
                );
              },
              child: const Scaffold(
                backgroundColor: Colors.transparent,
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: AccountFormSheet(),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/accounts/:id',
            pageBuilder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return NoTransitionPage(
                child: AccountDetailScreen(accountId: id),
              );
            },
          ),
        ],
      ),
    ],
  );
});

// ── Splash redirect widget ────────────────────────────────────────────────────
// Shown only during cold start before the first auth check completes.
// The router's redirect immediately sends the user to the right screen.
class _SplashRedirect extends ConsumerWidget {
  const _SplashRedirect();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFFE63939),
          strokeWidth: 2,
        ),
      ),
    );
  }
}

// ── Transition builders ───────────────────────────────────────────────────────
Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}