// lib/core/isar/schemas/category.dart
//
// PaisaPlus – Category Isar Schema
// ----------------------------------
// Categories organise transactions. PaisaPlus ships with a rich set of
// India-first default categories (Food, UPI, Fuel, Rent, EMI, Groceries,
// Festival, etc.) that are seeded on first launch. Users can add custom ones.
//
// Design decisions:
//  • iconCodePoint (int) — stores the Flutter/Material icon codepoint directly.
//    Fast, tiny, and avoids any icon font dependency or string→icon mapping at
//    query time. Display: Icon(IconData(iconCodePoint, fontFamily: 'MaterialIcons'))
//  • colorValue (int) — stores Color.value (ARGB int). Zero overhead at runtime.
//  • isSystem — system/default categories cannot be deleted by the user, only
//    hidden. This prevents orphaned transactions pointing at a deleted category.
//  • isHidden — user can "archive" a category without breaking history.
//  • parentCategoryId — enables one level of sub-categories. Null = top-level.
//    We deliberately cap at ONE level of nesting to keep UI simple (Kite-style).
//  • budgetAllocation — optional monthly INR paise amount. When set, this
//    category contributes to the budget system (Phase 3) without needing a
//    separate Budget record. Convenience shortcut for simple users.
//  • sortOrder — explicit ordering; user can drag-to-reorder categories.

import 'package:isar/isar.dart';

part 'category.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Enums
// ─────────────────────────────────────────────────────────────────────────────

/// Which transaction type(s) a category applies to.
/// Most categories are expense-only; a few are income-only (Salary, Freelance).
/// 'both' is rare but allowed (e.g. "Adjustment" category for corrections).
enum CategoryType {
  expense,
  income,
  both,
}

// ─────────────────────────────────────────────────────────────────────────────
// Schema
// ─────────────────────────────────────────────────────────────────────────────

@Collection()
class Category {
  // ── Identity ───────────────────────────────────────────────────────────────
  Id id = Isar.autoIncrement;

  /// Stable UUID — used in backup/restore matching and export.
  @Index(unique: true)
  late String uuid;

  // ── Display ────────────────────────────────────────────────────────────────

  /// User-facing category name. Shown on transaction cards, reports, etc.
  /// Example: "Food & Dining", "UPI Transfer", "Festival Shopping"
  @Index()
  late String name;

  /// Material Icons codepoint. Use like:
  ///   Icon(IconData(category.iconCodePoint, fontFamily: 'MaterialIcons'))
  /// Defaults to Icons.category.codePoint (0xe574) when not set.
  late int iconCodePoint;

  /// ARGB color integer. Use like: Color(category.colorValue)
  /// Zerodha-red (#E63939) = 0xFFE63939 for the first few defaults.
  late int colorValue;

  // ── Type & Structure ───────────────────────────────────────────────────────

  @enumerated
  late CategoryType type;

  /// Parent category ID for sub-categories. Null means top-level.
  /// Example: parentCategoryId set → "Breakfast" is a child of "Food & Dining".
  /// Max depth: 1 (no grandchildren — keeps UI manageable).
  @Index()
  int? parentCategoryId;

  // ── System vs User ─────────────────────────────────────────────────────────

  /// True for seed/default categories that ship with the app.
  /// System categories: cannot be deleted, name can be edited, icon can change.
  bool isSystem = false;

  /// True when the user has hidden this category from the picker.
  /// Hidden categories still appear in historical transaction data.
  bool isHidden = false;

  // ── Optional Budget Shortcut (Phase 3 hook) ────────────────────────────────

  /// Optional monthly budget allocated to this category, in paise.
  /// When set, the home dashboard can show a simple "Food: ₹3,200 / ₹5,000" chip
  /// without requiring a full Budget record. Phase 3 builds proper Budget on top.
  int? monthlyBudgetInPaise;

  // ── Ordering ───────────────────────────────────────────────────────────────

  /// Explicit display order. Lower = shown first.
  /// User drag-to-reorder updates these values in batch.
  int sortOrder = 0;

  // ── Timestamps ─────────────────────────────────────────────────────────────
  late DateTime createdAt;
  late DateTime updatedAt;

  // ── India-First Seeds ──────────────────────────────────────────────────────
  // These are documented here as reference for the seeding service.
  // Actual seed data lives in: lib/core/isar/seeds/category_seeds.dart
  //
  // Expense categories seeded on first launch:
  //   Food & Dining (fork+knife), Groceries (cart), Transport (car),
  //   Fuel (fuel pump), Auto/Cab (rickshaw), UPI Transfer (phone),
  //   Rent (house), EMI (bank), Electricity (bolt), Mobile/DTH (signal),
  //   Entertainment (movie), Shopping (bag), Medical (cross),
  //   Insurance (shield), Education (book), Salary Advance (rupee),
  //   Festival (diya/firework), Travel (plane), Personal Care (person),
  //   Gym/Fitness (dumbbell), Subscriptions (play button),
  //   Household (home), Clothing (shirt), Gifts (gift box),
  //   Pets (paw), Investment (trending up), Donation (heart),
  //   Miscellaneous (dots)
  //
  // Income categories seeded:
  //   Salary, Freelance, Business, Rental Income, Dividends,
  //   Interest, Gift Received, Refund, Cashback, Other Income
}