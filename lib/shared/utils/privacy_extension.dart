// lib/shared/utils/privacy_extension.dart
// ─────────────────────────────────────────────────────────────────────────────
// Privacy Mode Extension
// Used to mask financial amounts across the app when Privacy Mode is enabled.
// ─────────────────────────────────────────────────────────────────────────────

extension PrivacyStringExtension on String {
  /// Masks the string if [isPrivate] is true.
  /// Example: "₹ 1,200.00" -> "₹ ••••"
  /// If the string doesn't contain a currency symbol, it just returns "••••".
  String formatWithPrivacy(bool isPrivate) {
    if (!isPrivate) return this;
    
    // If the string starts with a currency symbol (e.g. ₹ or $), keep the symbol and mask the rest
    if (startsWith('₹') || startsWith('\$')) {
      return '${this[0]} ••••';
    } else if (startsWith('-₹') || startsWith('-\$')) {
      return '-${this[1]} ••••';
    }
    
    return '••••';
  }
}
