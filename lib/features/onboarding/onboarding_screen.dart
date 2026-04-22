// lib/features/onboarding/onboarding_screen.dart
// ─────────────────────────────────────────────────────────────────────────────
// 4-screen onboarding carousel — shown only on first launch.
// Matches App_Flow_Detailed.md spec exactly.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/isar/isar_service.dart';
import '../../shared/theme/app_colors.dart';
import '../../shared/router/app_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      emoji: '🔐',
      headline: 'Take control of your\nmoney — privately.',
      subheadline:
          'PaisaPlus is a fully offline expense tracker with Kite-level polish. No data leaves your phone. No subscriptions. Ever.',
      highlights: [
        ('🔒', '100% Local & Encrypted'),
        ('📊', 'Beautiful dashboards & insights'),
        ('🎁', 'Free forever — all features unlocked'),
      ],
      isLast: false,
    ),
    _OnboardingPage(
      emoji: '⚡',
      headline: 'Track expenses\nin seconds.',
      subheadline:
          'Add income, expenses, or transfers with our Kite-inspired calculator. Smart categories for India — UPI, Fuel, Rent, Groceries & more.',
      highlights: [
        ('➕', 'Quick FAB — add in one tap'),
        ('🔄', 'Recurring transactions'),
        ('📸', 'Photo & notes attachment'),
      ],
      isLast: false,
    ),
    _OnboardingPage(
      emoji: '🎯',
      headline: 'Budget smarter.\nUnderstand deeper.',
      subheadline:
          'Unlimited budgets, savings goals, loan trackers, and powerful offline reports. See where your money goes with beautiful visuals.',
      highlights: [
        ('📈', 'Monthly trends & insights'),
        ('🏆', 'Savings goals & loan tracker'),
        ('📉', 'Envelope budgeting'),
      ],
      isLast: false,
    ),
    _OnboardingPage(
      emoji: '🛡️',
      headline: 'Your data.\nYour rules.',
      subheadline:
          'Fully encrypted local storage • Biometric lock • Monthly local backup • One device per account. Admin approval keeps it private.',
      highlights: [
        ('🔑', 'Sign in with Google → Get approved'),
        ('📱', 'One device per account'),
        ('☁️', 'Your data never touches any cloud'),
      ],
      isLast: true,
    ),
  ];

  Future<void> _completeOnboarding() async {
    // Mark onboarding complete in Isar
    final settingsService =
        await ref.read(appSettingsServiceProvider.future);
    await settingsService.markOnboardingComplete();

    if (mounted) context.go(AppRoutes.signIn);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip button ────────────────────────────────────────────────
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ),
            ),

            // ── Page content ───────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                itemCount: _pages.length,
                itemBuilder: (context, idx) => _pages[idx],
              ),
            ),

            // ── Progress dots ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (idx) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == idx ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == idx
                          ? AppColors.primary
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // ── CTA Button ─────────────────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    isLast ? 'Continue with Google' : 'Next',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Onboarding page data model ────────────────────────────────────────────────
class _OnboardingPage extends StatelessWidget {
  final String emoji;
  final String headline;
  final String subheadline;
  final List<(String, String)> highlights;
  final bool isLast;

  const _OnboardingPage({
    required this.emoji,
    required this.headline,
    required this.subheadline,
    required this.highlights,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // ── Illustration / emoji ─────────────────────────────────────────
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 56)),
              ),
            ),
          ),

          const SizedBox(height: 36),

          // ── Headline ─────────────────────────────────────────────────────
          Text(
            headline,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 16),

          // ── Subheadline ───────────────────────────────────────────────────
          Text(
            subheadline,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 32),

          // ── Highlights ────────────────────────────────────────────────────
          ...highlights.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: Text(h.$1, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      h.$2,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}