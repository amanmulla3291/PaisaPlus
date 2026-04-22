// lib/core/isar/services/sync_service.dart
// ─────────────────────────────────────────────────────────────────────────────
// Handles metadata synchronization (structural only) to Supabase.
// NO financial amounts or transaction notes are synced.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/foundation.dart' hide Category;
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../schemas/account.dart';
import '../schemas/category.dart' as schema;

class SyncService {
  final Isar _isar;
  final SupabaseClient _supabase = Supabase.instance.client;
  
  SyncService(this._isar);

  String? get _userId => _supabase.auth.currentUser?.id;

  /// Starts watching local changes and pushing to Supabase.
  void startAutoSync() {
    if (_userId == null) return;

    // Watch Accounts
    _isar.accounts.watchLazy().listen((_) => _syncAccounts());
    
    // Watch Categories
    _isar.categorys.watchLazy().listen((_) => _syncCategories());
  }

  Future<void> _syncAccounts() async {
    if (_userId == null) return;
    
    final accounts = await _isar.accounts.where().findAll();
    final payloads = accounts.map((a) => {
      'user_id': _userId,
      'type': 'account',
      'uuid': a.uuid,
      'payload': {
        'name': a.name,
        'icon': a.iconCodePoint,
        'color': a.colorValue,
        'account_type': a.type.name,
        'sort_order': a.sortOrder,
        'is_archived': a.isArchived,
      },
      'updated_at': DateTime.now().toIso8601String(),
    }).toList();

    await _supabase.from('sync_metadata').upsert(
      payloads,
      onConflict: 'user_id, uuid',
    );
  }

  Future<void> _syncCategories() async {
    if (_userId == null) return;

    final categories = await _isar.categorys.where().findAll();
    
    final List<Map<String, dynamic>> payloads = [];
    
    for (final c in categories) {
      String? parentUuid;
      if (c.parentCategoryId != null) {
        final parent = await _isar.categorys.get(c.parentCategoryId!);
        parentUuid = parent?.uuid;
      }

      payloads.add({
        'user_id': _userId,
        'type': 'category',
        'uuid': c.uuid,
        'payload': {
          'name': c.name,
          'icon': c.iconCodePoint,
          'color': c.colorValue,
          'category_type': c.type.name,
          'parent_uuid': parentUuid,
          'is_hidden': c.isHidden,
          'sort_order': c.sortOrder,
        },
        'updated_at': DateTime.now().toIso8601String(),
      });
    }

    if (payloads.isNotEmpty) {
      await _supabase.from('sync_metadata').upsert(
        payloads,
        onConflict: 'user_id, uuid',
      );
    }
  }

  /// Pulls remote structure and merges into local Isar.
  Future<void> pullLatestStructure() async {
    if (_userId == null) return;

    final response = await _supabase
        .from('sync_metadata')
        .select()
        .eq('user_id', _userId!);

    await _isar.writeTxn(() async {
      for (final item in response) {
        final type = item['type'];
        final payload = item['payload'];
        final uuid = item['uuid'];

        if (type == 'account') {
          final existing = await _isar.accounts.where().uuidEqualTo(uuid).findFirst();
          if (existing == null) {
            final newAccount = Account()
              ..uuid = uuid
              ..name = payload['name']
              ..iconCodePoint = payload['icon']
              ..colorValue = payload['color']
              ..type = AccountType.values.byName(payload['account_type'])
              ..sortOrder = payload['sort_order']
              ..isArchived = payload['is_archived']
              ..openingBalanceInPaise = 0
              ..openingBalanceDate = DateTime.now()
              ..createdAt = DateTime.now()
              ..updatedAt = DateTime.now();
            await _isar.accounts.put(newAccount);
          }
        } else if (type == 'category') {
          final existing = await _isar.categorys.where().uuidEqualTo(uuid).findFirst();
          if (existing == null) {
            final newCat = schema.Category()
              ..uuid = uuid
              ..name = payload['name']
              ..iconCodePoint = payload['icon']
              ..colorValue = payload['color']
              ..type = schema.CategoryType.values.byName(payload['category_type'])
              ..isHidden = payload['is_hidden']
              ..sortOrder = payload['sort_order']
              ..createdAt = DateTime.now()
              ..updatedAt = DateTime.now();
            
            // Handle parent resolution
            final String? parentUuid = payload['parent_uuid'];
            if (parentUuid != null) {
              final parent = await _isar.categorys.where().uuidEqualTo(parentUuid).findFirst();
              if (parent != null) {
                newCat.parentCategoryId = parent.id;
              }
            }

            await _isar.categorys.put(newCat);
          }
        }
      }
    });
  }
}
