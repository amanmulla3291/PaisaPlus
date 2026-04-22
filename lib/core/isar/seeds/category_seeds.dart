// lib/core/isar/seeds/category_seeds.dart
//
// PaisaPlus – Default Category Seed Data
// ----------------------------------------
// Called once on first launch by CategoryService.seedDefaultCategories().
// Guards against re-seeding with: if (isar.categories.count() > 0) return;
//
// All amounts: 0 (no default budget). Icon codepoints from Icons constants.
// Color palette: Zerodha-red for first few, then a tasteful Kite-dark palette.
//
// India-first design:
//   • UPI Transfer as a first-class category (huge in India)
//   • Auto/Cab (Ola/Uber dominant)
//   • Festival spending (Diwali, Holi, etc.)
//   • EMI (very common for phone, appliance purchases)
//   • Salary Advance (common in informal sector)
//
// sortOrder follows the list order below (0-indexed).

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../schemas/account.dart';
import '../schemas/category.dart';

const _uuid = Uuid();

/// Returns all default categories ready to insert into Isar.
/// Call inside isar.writeTxn(() async { ... }) in CategoryService.
List<Category> buildDefaultCategories() {
  final now = DateTime.now();

  Category make({
    required String name,
    required IconData icon,
    required Color color,
    required CategoryType type,
    int? parentId,
    int sortOrder = 0,
  }) {
    return Category()
      ..uuid = _uuid.v4()
      ..name = name
      ..iconCodePoint = icon.codePoint
      ..colorValue = color.toARGB32()
      ..type = type
      ..parentCategoryId = parentId
      ..isSystem = true
      ..isHidden = false
      ..sortOrder = sortOrder
      ..createdAt = now
      ..updatedAt = now;
  }

  // ── Expense Categories ─────────────────────────────────────────────────────

  final expenseCategories = [
    make(
      name: 'Food & Dining',
      icon: Icons.restaurant,
      color: const Color(0xFFE63939), // Zerodha-red
      type: CategoryType.expense,
      sortOrder: 0,
    ),
    make(
      name: 'Groceries',
      icon: Icons.shopping_cart,
      color: const Color(0xFF4CAF50), // Green
      type: CategoryType.expense,
      sortOrder: 1,
    ),
    make(
      name: 'Transport',
      icon: Icons.directions_car,
      color: const Color(0xFF2196F3), // Blue
      type: CategoryType.expense,
      sortOrder: 2,
    ),
    make(
      name: 'Auto / Cab',
      icon: Icons.electric_rickshaw,
      color: const Color(0xFF03A9F4), // Light Blue
      type: CategoryType.expense,
      sortOrder: 3,
    ),
    make(
      name: 'Fuel',
      icon: Icons.local_gas_station,
      color: const Color(0xFFFF9800), // Orange
      type: CategoryType.expense,
      sortOrder: 4,
    ),
    make(
      name: 'UPI Transfer',
      icon: Icons.phone_android,
      color: const Color(0xFF9C27B0), // Purple
      type: CategoryType.expense,
      sortOrder: 5,
    ),
    make(
      name: 'Rent',
      icon: Icons.home,
      color: const Color(0xFF607D8B), // Blue-Grey
      type: CategoryType.expense,
      sortOrder: 6,
    ),
    make(
      name: 'EMI',
      icon: Icons.account_balance,
      color: const Color(0xFF795548), // Brown
      type: CategoryType.expense,
      sortOrder: 7,
    ),
    make(
      name: 'Electricity & Bills',
      icon: Icons.bolt,
      color: const Color(0xFFFFEB3B), // Yellow
      type: CategoryType.expense,
      sortOrder: 8,
    ),
    make(
      name: 'Mobile & DTH',
      icon: Icons.signal_cellular_alt,
      color: const Color(0xFF00BCD4), // Cyan
      type: CategoryType.expense,
      sortOrder: 9,
    ),
    make(
      name: 'Entertainment',
      icon: Icons.movie,
      color: const Color(0xFFE91E63), // Pink
      type: CategoryType.expense,
      sortOrder: 10,
    ),
    make(
      name: 'Shopping',
      icon: Icons.shopping_bag,
      color: const Color(0xFFFF5722), // Deep Orange
      type: CategoryType.expense,
      sortOrder: 11,
    ),
    make(
      name: 'Medical & Health',
      icon: Icons.local_hospital,
      color: const Color(0xFFF44336), // Red
      type: CategoryType.expense,
      sortOrder: 12,
    ),
    make(
      name: 'Insurance',
      icon: Icons.shield,
      color: const Color(0xFF3F51B5), // Indigo
      type: CategoryType.expense,
      sortOrder: 13,
    ),
    make(
      name: 'Education',
      icon: Icons.menu_book,
      color: const Color(0xFF009688), // Teal
      type: CategoryType.expense,
      sortOrder: 14,
    ),
    make(
      name: 'Festival & Gifts',
      icon: Icons.celebration,
      color: const Color(0xFFFF6F00), // Amber-dark
      type: CategoryType.expense,
      sortOrder: 15,
    ),
    make(
      name: 'Travel',
      icon: Icons.flight,
      color: const Color(0xFF1976D2), // Blue-dark
      type: CategoryType.expense,
      sortOrder: 16,
    ),
    make(
      name: 'Personal Care',
      icon: Icons.face,
      color: const Color(0xFFAD1457), // Pink-dark
      type: CategoryType.expense,
      sortOrder: 17,
    ),
    make(
      name: 'Gym & Fitness',
      icon: Icons.fitness_center,
      color: const Color(0xFF558B2F), // Green-dark
      type: CategoryType.expense,
      sortOrder: 18,
    ),
    make(
      name: 'Subscriptions',
      icon: Icons.subscriptions,
      color: const Color(0xFF6A1B9A), // Purple-dark
      type: CategoryType.expense,
      sortOrder: 19,
    ),
    make(
      name: 'Household',
      icon: Icons.chair,
      color: const Color(0xFF4E342E), // Brown-dark
      type: CategoryType.expense,
      sortOrder: 20,
    ),
    make(
      name: 'Clothing',
      icon: Icons.checkroom,
      color: const Color(0xFFB71C1C), // Red-dark
      type: CategoryType.expense,
      sortOrder: 21,
    ),
    make(
      name: 'Pets',
      icon: Icons.pets,
      color: const Color(0xFF827717), // Yellow-dark
      type: CategoryType.expense,
      sortOrder: 22,
    ),
    make(
      name: 'Investment',
      icon: Icons.trending_up,
      color: const Color(0xFF1B5E20), // Green-darkest
      type: CategoryType.expense,
      sortOrder: 23,
    ),
    make(
      name: 'Donation & Charity',
      icon: Icons.favorite,
      color: const Color(0xFFE53935), // Red-medium
      type: CategoryType.expense,
      sortOrder: 24,
    ),
    make(
      name: 'Miscellaneous',
      icon: Icons.more_horiz,
      color: const Color(0xFF546E7A), // Grey
      type: CategoryType.expense,
      sortOrder: 25,
    ),
  ];

  // ── Income Categories ──────────────────────────────────────────────────────

  final incomeCategories = [
    make(
      name: 'Salary',
      icon: Icons.payments,
      color: const Color(0xFF43A047), // Green
      type: CategoryType.income,
      sortOrder: 0,
    ),
    make(
      name: 'Freelance',
      icon: Icons.laptop_mac,
      color: const Color(0xFF1565C0), // Blue-dark
      type: CategoryType.income,
      sortOrder: 1,
    ),
    make(
      name: 'Business',
      icon: Icons.business_center,
      color: const Color(0xFF6A1B9A), // Purple
      type: CategoryType.income,
      sortOrder: 2,
    ),
    make(
      name: 'Rental Income',
      icon: Icons.home_work,
      color: const Color(0xFF00695C), // Teal-dark
      type: CategoryType.income,
      sortOrder: 3,
    ),
    make(
      name: 'Dividends',
      icon: Icons.bar_chart,
      color: const Color(0xFF558B2F), // Green-dark
      type: CategoryType.income,
      sortOrder: 4,
    ),
    make(
      name: 'Interest',
      icon: Icons.account_balance_wallet,
      color: const Color(0xFF0277BD), // Blue-medium
      type: CategoryType.income,
      sortOrder: 5,
    ),
    make(
      name: 'Gift Received',
      icon: Icons.card_giftcard,
      color: const Color(0xFFE65100), // Orange-dark
      type: CategoryType.income,
      sortOrder: 6,
    ),
    make(
      name: 'Refund',
      icon: Icons.replay,
      color: const Color(0xFF00838F), // Cyan-dark
      type: CategoryType.income,
      sortOrder: 7,
    ),
    make(
      name: 'Cashback',
      icon: Icons.redeem,
      color: const Color(0xFFC62828), // Red-dark
      type: CategoryType.income,
      sortOrder: 8,
    ),
    make(
      name: 'Salary Advance',
      icon: Icons.currency_rupee,
      color: const Color(0xFF37474F), // Blue-Grey-dark
      type: CategoryType.income,
      sortOrder: 9,
    ),
    make(
      name: 'Other Income',
      icon: Icons.add_circle_outline,
      color: const Color(0xFF546E7A), // Grey
      type: CategoryType.income,
      sortOrder: 10,
    ),
  ];

  // ── System: Transfer (both type) ───────────────────────────────────────────

  final transferCategory = make(
    name: 'Transfer',
    icon: Icons.swap_horiz,
    color: const Color(0xFF78909C), // Blue-Grey-light
    type: CategoryType.both,
    sortOrder: 999, // Hidden at bottom — system use only
  );

  return [
    ...expenseCategories,
    ...incomeCategories,
    transferCategory,
  ];
}

/// Default accounts seeded on first launch.
/// Called by AccountService.seedDefaultAccounts() inside writeTxn.
List<Account> buildDefaultAccounts() {
  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);

  Account make({
    required String name,
    required IconData icon,
    required Color color,
    required AccountType type,
    int sortOrder = 0,
  }) {
    return Account()
      ..uuid = const Uuid().v4()
      ..name = name
      ..iconCodePoint = icon.codePoint
      ..colorValue = color.toARGB32()
      ..type = type
      ..openingBalanceInPaise = 0
      ..openingBalanceDate = startOfToday
      ..isExcludedFromTotal = false
      ..isArchived = false
      ..sortOrder = sortOrder
      ..createdAt = now
      ..updatedAt = now;
  }

  return [
    make(
      name: 'Cash',
      icon: Icons.wallet,
      color: const Color(0xFF4CAF50), // Green
      type: AccountType.cash,
      sortOrder: 0,
    ),
    make(
      name: 'Bank Account',
      icon: Icons.account_balance,
      color: const Color(0xFF2196F3), // Blue
      type: AccountType.bankAccount,
      sortOrder: 1,
    ),
    make(
      name: 'UPI / Digital Wallet',
      icon: Icons.phone_android,
      color: const Color(0xFF9C27B0), // Purple
      type: AccountType.digitalWallet,
      sortOrder: 2,
    ),
  ];
}