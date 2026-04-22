// lib/core/isar/isar_service.dart
// ─────────────────────────────────────────────────────────────────────────────
// Isar 3.1.0+1 — single database instance for the entire app.
// Phase 1 + Phase 2 schemas all registered here.
// DB name: 'paisaplus_db' (matches Phase 1 — do NOT change or existing
// AppSettings data will be lost).
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:math';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Phase 1 models
import 'models/app_settings.dart';

// Phase 2 schemas
import 'schemas/account.dart';
import 'schemas/category.dart';
import 'schemas/transaction.dart';
import 'schemas/budget.dart';
import 'schemas/goal.dart';
import 'schemas/loan.dart';
import 'schemas/recurring_rule.dart';
import 'schemas/subscription.dart';

const _kIsarEncryptionKey = 'paisaplus_isar_encryption_key';

const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

/// Generates and persists a 32-byte key in secure storage.
/// Key is ready for Isar 4.x encryption upgrade.
Future<void> _ensureEncryptionKey() async {
  final stored = await _secureStorage.read(key: _kIsarEncryptionKey);
  if (stored == null) {
    final random = Random.secure();
    final keyBytes = List<int>.generate(32, (_) => random.nextInt(256));
    await _secureStorage.write(
      key: _kIsarEncryptionKey,
      value: base64Url.encode(keyBytes),
    );
  }
}

/// Opens the single Isar instance with ALL schemas registered.
/// Returns existing instance if already open (idempotent).
Future<Isar> openEncryptedIsar() async {
  await _ensureEncryptionKey();
  final dir = await getApplicationDocumentsDirectory();

  // Return existing instance — safe to call multiple times
  if (Isar.instanceNames.contains('paisaplus_db')) {
    return Isar.getInstance('paisaplus_db')!;
  }

  return Isar.open(
    [
      // Phase 1
      AppSettingsSchema,
      // Phase 2
      TransactionSchema,
      CategorySchema,
      AccountSchema,
      BudgetSchema,
      GoalSchema,
      LoanSchema,
      RecurringRuleSchema,
      SubscriptionSchema,
    ],
    directory: dir.path,
    name: 'paisaplus_db',   // MUST match Phase 1 name
    inspector: false,
  );
}

// ── Core Isar provider ────────────────────────────────────────────────────────
// Single FutureProvider — every service reads from this.

final isarProvider = FutureProvider<Isar>((ref) async {
  return openEncryptedIsar();
});

// ── AppSettings helpers (Phase 1 — unchanged) ─────────────────────────────────

IsarCollection<AppSettings> _appSettingsCol(Isar isar) =>
    isar.collection<AppSettings>();

final appSettingsProvider = StreamProvider<AppSettings>((ref) async* {
  final isar = await ref.watch(isarProvider.future);
  final col = _appSettingsCol(isar);
  
  final initial = await col.where().findFirst();
  if (initial == null) {
    final defaults = AppSettings();
    await isar.writeTxn(() async => col.put(defaults));
    yield defaults;
  } else {
    yield initial;
  }

  // Watch for ANY changes to the first settings object (id: 1 usually)
  yield* col.watchObject(initial?.id ?? 1).where((s) => s != null).cast<AppSettings>();
});

class AppSettingsService {
  final Isar _isar;
  AppSettingsService(this._isar);

  IsarCollection<AppSettings> get _col => _appSettingsCol(_isar);

  Future<AppSettings> getOrCreate() async {
    final existing = await _col.where().findFirst();
    if (existing != null) return existing;
    final defaults = AppSettings();
    await _isar.writeTxn(() async => _col.put(defaults));
    return defaults;
  }

  Future<void> _update(void Function(AppSettings s) mutate) async {
    final s = await getOrCreate();
    mutate(s);
    await _isar.writeTxn(() async => _col.put(s));
  }

  Future<void> markOnboardingComplete() =>
      _update((s) => s.onboardingCompleted = true);

  Future<void> markSetupComplete() =>
      _update((s) => s.setupCompleted = true);

  Future<void> updateBackupDate() =>
      _update((s) => s.lastBackupDate = DateTime.now());

  Future<void> setBiometric(bool enabled) =>
      _update((s) => s.biometricEnabled = enabled);

  Future<void> setPrivacyMode(bool enabled) =>
      _update((s) => s.privacyModeEnabled = enabled);
}

final appSettingsServiceProvider =
    FutureProvider<AppSettingsService>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return AppSettingsService(isar);
});

// A reactive provider to instantly react to privacy mode changes across the UI
final privacyModeProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsProvider).valueOrNull?.privacyModeEnabled ?? false;
});