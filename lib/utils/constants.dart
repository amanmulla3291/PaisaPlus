// lib/utils/constants.dart
// ─────────────────────────────────────────────────────────────────────────────
// App-wide constants for PaisaPlus.
// ─────────────────────────────────────────────────────────────────────────────

class AppConstants {
  AppConstants._();

  // ── App info ──────────────────────────────────────────────────────────────
  static const String appName = 'PaisaPlus';
  static const String appVersion = '1.0.0';

  // ── Backup ────────────────────────────────────────────────────────────────
  static const String backupFileExtension = '.enc';
  static const String backupFilePrefix = 'PaisaPlus_Backup_';

  // ── Isar ──────────────────────────────────────────────────────────────────
  static const String isarDbName = 'paisaplus_db';

  // ── SharedPreferences keys ────────────────────────────────────────────────
  static const String keyOnboardingDone = 'onboarding_done';
  static const String keyFirstLaunch = 'first_launch';

  // ── India defaults ────────────────────────────────────────────────────────
  static const String defaultCurrencyCode = 'INR';
  static const String defaultCurrencySymbol = '₹';
  static const String defaultLocale = 'en_IN';
}