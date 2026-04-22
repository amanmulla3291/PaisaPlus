// lib/core/isar/services/category_service.dart
//
// PaisaPlus – CategoryService
// -----------------------------
// Single source of truth for Category reads, writes, and first-launch seeding.
//
// Design notes:
//  • System categories (isSystem == true) cannot be deleted — only hidden.
//    Attempting hardDelete on a system category throws an assertion.
//  • Seeding is idempotent: seedDefaultCategories() checks count > 0 and exits.
//  • The Transfer system category is always present and used internally for
//    transfer transactions. Users never see it in the picker.
//  • Sub-categories (parentCategoryId != null) are fetched separately when
//    building the full category tree for the picker UI.
//  • Category search (for the quick-add calculator picker) uses contains()
//    which is a linear scan — fast enough for the expected 30–50 categories.

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../schemas/category.dart';
import '../seeds/category_seeds.dart';

const _uuid = Uuid();

/// A node in the category tree for the picker UI.
class CategoryNode {
  final Category category;
  final List<Category> children;

  const CategoryNode({required this.category, this.children = const []});

  bool get hasChildren => children.isNotEmpty;
}

class CategoryService {
  final Isar _isar;

  CategoryService(this._isar);

  // ══════════════════════════════════════════════════════════════════════════
  // SEEDING
  // ══════════════════════════════════════════════════════════════════════════

  /// Seed default categories on first launch.
  /// Idempotent — safe to call on every app open.
  Future<void> seedDefaultCategories() async {
    final count = await _isar.categorys.count();
    if (count > 0) return;

    final defaults = buildDefaultCategories();
    await _isar.writeTxn(() async {
      await _isar.categorys.putAll(defaults);
    });
  }

  // ══════════════════════════════════════════════════════════════════════════
  // WRITE OPERATIONS
  // ══════════════════════════════════════════════════════════════════════════

  /// Create a new user-defined category. Returns the new Isar id.
  Future<Id> addCategory(Category category) async {
    assert(!category.isSystem,
        'isSystem must be false for user-created categories');

    final now = DateTime.now();
    category
      ..uuid = _uuid.v4()
      ..isSystem = false
      ..createdAt = now
      ..updatedAt = now;

    return _isar.writeTxn(() async {
      return _isar.categorys.put(category);
    });
  }

  /// Update a category (name, icon, colour, budget).
  /// System categories: can update name/icon/colour but not isSystem or type.
  Future<void> updateCategory(Category category) async {
    category.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.categorys.put(category);
    });
  }

  /// Hide a category from the picker.
  /// Both system and user categories can be hidden.
  /// Hidden categories still appear in historical data.
  Future<void> hideCategory(Id id) async {
    final category = await _isar.categorys.get(id);
    if (category == null) return;

    category
      ..isHidden = true
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.categorys.put(category);
    });
  }

  /// Unhide a previously hidden category.
  Future<void> unhideCategory(Id id) async {
    final category = await _isar.categorys.get(id);
    if (category == null) return;

    category
      ..isHidden = false
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.categorys.put(category);
    });
  }

  /// Delete a user-created category permanently.
  /// Throws if the category is a system category.
  /// WARNING: Transactions pointing at this categoryId will have an orphan
  /// reference. Caller MUST reassign those transactions first (UI handles this).
  Future<void> hardDelete(Id id) async {
    final category = await _isar.categorys.get(id);
    if (category == null) return;
    assert(
      !category.isSystem,
      'System categories cannot be deleted. Use hideCategory() instead.',
    );

    await _isar.writeTxn(() async {
      await _isar.categorys.delete(id);
      // Also delete any sub-categories
      final children = await _isar.categorys
          .filter()
          .parentCategoryIdEqualTo(id)
          .findAll();
      for (final child in children) {
        await _isar.categorys.delete(child.id);
      }
    });
  }

  /// Set monthly budget for a category (convenience — avoids opening Category editor).
  Future<void> setBudget(Id id, int? amountInPaise) async {
    final category = await _isar.categorys.get(id);
    if (category == null) return;

    category
      ..monthlyBudgetInPaise = amountInPaise
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.categorys.put(category);
    });
  }

  /// Batch reorder — called after drag-to-reorder in settings.
  Future<void> reorder(List<({Id id, int sortOrder})> updates) async {
    await _isar.writeTxn(() async {
      for (final u in updates) {
        final category = await _isar.categorys.get(u.id);
        if (category != null) {
          category
            ..sortOrder = u.sortOrder
            ..updatedAt = DateTime.now();
          await _isar.categorys.put(category);
        }
      }
    });
  }

  // ══════════════════════════════════════════════════════════════════════════
  // READ OPERATIONS
  // ══════════════════════════════════════════════════════════════════════════

  Future<Category?> getById(Id id) async {
    return _isar.categorys.get(id);
  }

  Future<Category?> getByUuid(String uuid) async {
    return _isar.categorys.where().uuidEqualTo(uuid).findFirst();
  }

  /// All visible (non-hidden) top-level expense categories, sorted.
  Future<List<Category>> getVisibleExpenseCategories() async {
    return _isar.categorys
        .filter()
        .isHiddenEqualTo(false)
        .and()
        .parentCategoryIdIsNull()
        .and()
        .not()
        .typeEqualTo(CategoryType.income)
        .sortBySortOrder()
        .findAll();
  }

  /// All visible top-level income categories, sorted.
  Future<List<Category>> getVisibleIncomeCategories() async {
    return _isar.categorys
        .filter()
        .isHiddenEqualTo(false)
        .and()
        .parentCategoryIdIsNull()
        .and()
        .not()
        .typeEqualTo(CategoryType.expense)
        .sortBySortOrder()
        .findAll();
  }

  /// All categories (for the transaction add/edit picker), filtered by type.
  /// Excludes the internal "Transfer" system category.
  Future<List<Category>> getForPicker(CategoryType type) async {
    if (type == CategoryType.expense) {
      return getVisibleExpenseCategories();
    } else if (type == CategoryType.income) {
      return getVisibleIncomeCategories();
    }
    return [];
  }

  /// Build the full category tree for a given type (parent + children).
  /// Used by the category picker sheet that shows collapsible groups.
  Future<List<CategoryNode>> getCategoryTree(CategoryType type) async {
    final allCategories = await _isar.categorys
        .filter()
        .isHiddenEqualTo(false)
        .sortBySortOrder()
        .findAll();

    // Split into parents and children
    final parents = allCategories.where((c) {
      if (c.name == 'Transfer') return false; // exclude system transfer
      if (c.parentCategoryId != null) return false; // only top-level
      if (type == CategoryType.expense) {
        return c.type == CategoryType.expense || c.type == CategoryType.both;
      } else {
        return c.type == CategoryType.income || c.type == CategoryType.both;
      }
    }).toList();

    final childrenByParent = <int, List<Category>>{};
    for (final c in allCategories) {
      if (c.parentCategoryId != null) {
        childrenByParent
            .putIfAbsent(c.parentCategoryId!, () => [])
            .add(c);
      }
    }

    return parents
        .map((parent) => CategoryNode(
              category: parent,
              children: childrenByParent[parent.id] ?? [],
            ))
        .toList();
  }

  /// Get sub-categories for a given parent.
  Future<List<Category>> getChildren(Id parentId) async {
    return _isar.categorys
        .filter()
        .isHiddenEqualTo(false)
        .and()
        .parentCategoryIdEqualTo(parentId)
        .sortBySortOrder()
        .findAll();
  }

  /// All categories including hidden — for the settings management screen.
  Future<List<Category>> getAllForSettings() async {
    return _isar.categorys
        .filter()
        .parentCategoryIdIsNull()
        .sortBySortOrder()
        .findAll();
  }

  /// Search categories by name — used by the quick-add calculator search.
  Future<List<Category>> search(String query, {CategoryType? type}) async {
    if (query.isEmpty) return getForPicker(type ?? CategoryType.expense);

    var dbQuery = _isar.categorys
        .filter()
        .isHiddenEqualTo(false)
        .and()
        .nameContains(query, caseSensitive: false);

    if (type == CategoryType.expense) {
      dbQuery = dbQuery.and().not().typeEqualTo(CategoryType.income);
    } else if (type == CategoryType.income) {
      dbQuery = dbQuery.and().not().typeEqualTo(CategoryType.expense);
    }

    return dbQuery.sortBySortOrder().findAll();
  }

  /// Get the internal Transfer system category id.
  /// Used when creating transfer Transaction pairs.
  Future<Id?> getTransferCategoryId() async {
    final cat = await _isar.categorys
        .filter()
        .nameEqualTo('Transfer')
        .isSystemEqualTo(true)
        .findFirst();
    return cat?.id;
  }

  /// All categories that have a monthlyBudget set — used by budget overview.
  Future<List<Category>> getWithBudgets() async {
    final all = await _isar.categorys
        .filter()
        .isHiddenEqualTo(false)
        .findAll();

    return all
        .where((c) =>
            c.monthlyBudgetInPaise != null && c.monthlyBudgetInPaise! > 0)
        .toList();
  }

  // ══════════════════════════════════════════════════════════════════════════
  // WATCH (Reactive streams)
  // ══════════════════════════════════════════════════════════════════════════

  Stream<void> watchAll() {
    return _isar.categorys.watchLazy();
  }

  /// Watch visible categories for a given type — used by transaction add sheet
  /// to reactively update when user creates a new category mid-flow.
  Stream<List<Category>> watchVisible(CategoryType type) {
    if (type == CategoryType.expense) {
      return _isar.categorys
          .filter()
          .isHiddenEqualTo(false)
          .and()
          .parentCategoryIdIsNull()
          .and()
          .not()
          .typeEqualTo(CategoryType.income)
          .watch(fireImmediately: true);
    } else {
      return _isar.categorys
          .filter()
          .isHiddenEqualTo(false)
          .and()
          .parentCategoryIdIsNull()
          .and()
          .not()
          .typeEqualTo(CategoryType.expense)
          .watch(fireImmediately: true);
    }
  }
}