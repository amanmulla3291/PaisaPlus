// lib/utils/extensions.dart
// ─────────────────────────────────────────────────────────────────────────────
// Dart extensions for PaisaPlus.
// INR formatting, date helpers, etc.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  /// Format as INR: ₹1,23,456.78
  String toINR({bool showSymbol = true}) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: showSymbol ? '₹' : '',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  /// Format as compact INR: ₹1.2L, ₹45K
  String toINRCompact() {
    if (abs() >= 10000000) return '₹${(this / 10000000).toStringAsFixed(1)}Cr';
    if (abs() >= 100000) return '₹${(this / 100000).toStringAsFixed(1)}L';
    if (abs() >= 1000) return '₹${(this / 1000).toStringAsFixed(1)}K';
    return toINR();
  }
}

extension DateTimeExtensions on DateTime {
  /// Format: 09 Apr 2026
  String toDisplayDate() => DateFormat('dd MMM yyyy').format(this);

  /// Format: Apr 2026
  String toMonthYear() => DateFormat('MMM yyyy').format(this);

  /// Format: 09 Apr
  String toDayMonth() => DateFormat('dd MMM').format(this);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

extension StringExtensions on String {
  /// Capitalise first letter
  String get capitalised =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}