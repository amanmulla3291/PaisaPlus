import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFFE63939);        // Zerodha red
  static const Color primaryDark = Color(0xFFCC2020);    // Pressed state
  static const Color primaryLight = Color(0xFFFF5555);   // Highlight

  // ── Background layers (dark theme) ────────────────────────────────────────
  static const Color background = Color(0xFF0A0A0A);     // Deepest background
  static const Color surface = Color(0xFF141414);        // Cards, sheets
  static const Color surfaceVariant = Color(0xFF1E1E1E); // Elevated surfaces
  static const Color surfaceHigh = Color(0xFF262626);    // Highest elevation

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFFFFFF);    // Main text
  static const Color textSecondary = Color(0xFFB0B0B0);  // Subdued text
  static const Color textTertiary = Color(0xFF707070);   // Placeholder / hint
  static const Color textDisabled = Color(0xFF404040);   // Disabled

  // ── Borders & dividers ────────────────────────────────────────────────────
  static const Color border = Color(0xFF2A2A2A);
  static const Color divider = Color(0xFF1E1E1E);

  // ── Semantic: Income / Expense / Neutral ──────────────────────────────────
  static const Color income = Color(0xFF00C07A);         // Green — money in
  static const Color expense = Color(0xFFE63939);        // Red — money out
  static const Color transfer = Color(0xFF4A9EFF);       // Blue — transfers
  static const Color neutral = Color(0xFF8A8A8A);        // Neutral

  // ── Chart accent palette (fl_chart) ──────────────────────────────────────
  static const List<Color> chartColors = [
    Color(0xFFE63939), // Red
    Color(0xFF4A9EFF), // Blue
    Color(0xFF00C07A), // Green
    Color(0xFFFFB444), // Amber
    Color(0xFFBB7BFF), // Purple
    Color(0xFFFF6B9D), // Pink
    Color(0xFF44D7E8), // Cyan
    Color(0xFFFF8C44), // Orange
  ];

  // ── Status ────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF00C07A);
  static const Color warning = Color(0xFFFFB444);
  static const Color error = Color(0xFFE63939);
  static const Color info = Color(0xFF4A9EFF);

  // ── Overlay ───────────────────────────────────────────────────────────────
  static const Color overlay = Color(0x80000000);        // 50% black overlay
  static const Color shimmer = Color(0xFF1E1E1E);        // Loading shimmer base
  static const Color shimmerHighlight = Color(0xFF2A2A2A);
}