// lib/core/isar/models/app_settings.dart
// ─────────────────────────────────────────────────────────────────────────────
// AppSettings — stored in encrypted local Isar DB.
// Contains ONLY app configuration — no financial data.
// Written as a manual Isar collection (no isar_generator needed).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  // ── Backup settings ───────────────────────────────────────────────────────
  /// Last time user created a local backup
  DateTime? lastBackupDate;

  /// How often to remind user to backup (in months): 1, 3, 6, or 12
  int backupIntervalMonths = 1;

  // ── Locale & display ─────────────────────────────────────────────────────
  /// Currency code — defaults to INR for India
  String currencyCode = 'INR';

  /// Currency symbol
  String currencySymbol = '₹';

  // ── Security ─────────────────────────────────────────────────────────────
  /// Whether biometric/PIN lock is enabled for the app
  bool biometricEnabled = false;

  /// Whether app lock PIN is set (legacy/unused if relying on OS fallback)
  bool pinEnabled = false;

  /// Whether privacy mode (masking sensitive balances) is enabled
  bool privacyModeEnabled = false;

  // ── Onboarding ───────────────────────────────────────────────────────────
  /// Whether the user has completed the 4-screen onboarding carousel
  bool onboardingCompleted = false;

  // ── First-time setup ─────────────────────────────────────────────────────
  /// Whether the post-approval setup wizard has been completed
  bool setupCompleted = false;

  // ── Theme ─────────────────────────────────────────────────────────────────
  /// Always dark — kept for future dynamic theme support
  bool isDarkMode = true;
}