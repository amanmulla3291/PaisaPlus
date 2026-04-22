// lib/shared/theme/app_theme.dart
//
// PaisaPlus – App Theme
// ----------------------
// Single source of truth for all colors, typography, and ThemeData.
// Kite-level fintech dark theme. Zerodha-red (#E63939) as the sole accent.
//
// Usage:
//   Color c = AppTheme.zerodhaRed;
//   TextStyle s = AppTheme.displayAmount;
//   // In MaterialApp: theme: AppTheme.darkTheme

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  // ── Brand Colors ───────────────────────────────────────────────────────────

  /// Primary accent — Zerodha Kite red. Used for: FAB, CTAs, active states,
  /// positive accents, selected indicators.
  static const Color zerodhaRed = Color(0xFFE63939);

  /// Slightly muted red for destructive actions (delete confirmations).
  static const Color redDestructive = Color(0xFFCC2929);

  /// Positive/income green. Subtle — never competes with red.
  static const Color incomeGreen = Color(0xFF26A69A); // teal-green (Kite-style)

  /// Warning amber for budget alerts.
  static const Color warningAmber = Color(0xFFFFA726);

  // ── Background & Surface Hierarchy ────────────────────────────────────────
  // Follows a 3-level elevation system:
  //   background → surface → surfaceVariant
  // Cards sit on surface, modals/sheets on surfaceVariant.

  /// Main scaffold background. Near-black with a very subtle warm tint.
  static const Color background = Color(0xFF0F0F0F);

  /// Card/panel surface. Slightly lighter than background.
  static const Color surface = Color(0xFF1A1A1A);

  /// Elevated surfaces (modals, bottom sheets, dropdowns).
  static const Color surfaceVariant = Color(0xFF222222);

  /// Dividers, borders, separators.
  static const Color divider = Color(0xFF2A2A2A);

  /// Interactive surface hover/pressed state.
  static const Color surfaceHover = Color(0xFF242424);

  // ── Text Colors ────────────────────────────────────────────────────────────

  /// Primary text — headlines, amounts. Near-white.
  static const Color textPrimary = Color(0xFFF5F5F5);

  /// Secondary text — labels, subtitles.
  static const Color textSecondary = Color(0xFF9E9E9E);

  /// Tertiary / disabled text.
  static const Color textTertiary = Color(0xFF5A5A5A);

  /// Text on colored (red) backgrounds.
  static const Color textOnRed = Color(0xFFFFFFFF);

  // ── Chart Palette ─────────────────────────────────────────────────────────
  // 12 distinct colors for pie chart segments. Designed for dark backgrounds.
  // Ordered by visual weight — most saturated first.

  static const List<Color> chartPalette = [
    Color(0xFFE63939), // Red (primary)
    Color(0xFF26A69A), // Teal
    Color(0xFFFFB300), // Amber
    Color(0xFF5C6BC0), // Indigo
    Color(0xFF42A5F5), // Blue
    Color(0xFF66BB6A), // Green
    Color(0xFFEF5350), // Light Red
    Color(0xFFAB47BC), // Purple
    Color(0xFF26C6DA), // Cyan
    Color(0xFFD4E157), // Lime
    Color(0xFFFF7043), // Deep Orange
    Color(0xFF8D6E63), // Brown
  ];

  // ── Typography ─────────────────────────────────────────────────────────────
  // Kite uses bold, large monetary amounts with tight letter-spacing.
  // Body text is clean and functional.

  /// The hero amount on the Balance Card. 36sp, extra-bold, tight tracking.
  static const TextStyle displayAmount = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: textPrimary,
    letterSpacing: -1.5,
    height: 1.0,
  );

  /// Smaller amounts on account cards, KPI chips. 22sp bold.
  static const TextStyle cardAmount = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.8,
    height: 1.1,
  );

  /// Transaction list amount. 16sp semi-bold.
  static const TextStyle listAmount = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: -0.3,
  );

  /// Card labels, section sub-labels. 12sp medium.
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    letterSpacing: 0.2,
  );

  /// Caption / metadata. 11sp regular.
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: textTertiary,
    letterSpacing: 0.1,
  );

  // ── ThemeData ─────────────────────────────────────────────────────────────

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: zerodhaRed,
        onPrimary: textOnRed,
        secondary: incomeGreen,
        onSecondary: textPrimary,
        surface: surface,
        onSurface: textPrimary,
        error: redDestructive,
        onError: textOnRed,
        outline: divider,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: background,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: divider, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: zerodhaRed,
        unselectedItemColor: textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),

      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: zerodhaRed,
        foregroundColor: textOnRed,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // Input / TextField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: zerodhaRed, width: 1.5),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textTertiary),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant,
        selectedColor: zerodhaRed.withValues(alpha: 0.18),
        labelStyle: const TextStyle(
          fontSize: 12,
          color: textPrimary,
          fontWeight: FontWeight.w500,
        ),
        side: const BorderSide(color: divider),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 0.5,
        space: 0,
      ),

      // List tile
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: textSecondary,
        textColor: textPrimary,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      // Text
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 36, fontWeight: FontWeight.w800, color: textPrimary),
        titleLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
        titleMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
        bodyLarge: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: textPrimary),
        bodyMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: textSecondary),
        labelSmall: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w500, color: textTertiary),
      ),
    );
  }
}
