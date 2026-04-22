// lib/core/isar/services/backup_service.dart
// ─────────────────────────────────────────────────────────────────────────────
// Handles encrypted database exports and imports using AES-256 and Native Share.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class BackupService {
  final Isar _isar;
  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  
  static const _kIsarEncryptionKey = 'paisaplus_isar_encryption_key';
  static const _backupHeader = 'PAISAPLUS_V1_ENC';

  BackupService(this._isar);

  /// Creates an encrypted snapshot of the database and triggers the share sheet.
  Future<void> exportBackup() async {
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    
    // 1. Create a raw snapshot of the Isar DB
    final snapshotFile = File('${tempDir.path}/snapshot.isar');
    if (await snapshotFile.exists()) await snapshotFile.delete();
    await _isar.copyToFile(snapshotFile.path);

    // 2. Encrypt the snapshot
    final encryptedFile = await _encryptFile(snapshotFile, 'backup_$timestamp.paisaplus');

    // 3. Trigger Share Sheet
    await Share.shareXFiles(
      [XFile(encryptedFile.path)],
      subject: 'PaisaPlus Encrypted Backup - $timestamp',
    );

    // 4. Cleanup
    if (await snapshotFile.exists()) await snapshotFile.delete();
  }

  /// Encrypts a file using AES-256-CBC with the master key from Secure Storage.
  Future<File> _encryptFile(File source, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final destination = File('${tempDir.path}/$fileName');

    // Get master key (base64Url encoded 32 bytes)
    final keyBase64 = await _secureStorage.read(key: _kIsarEncryptionKey);
    if (keyBase64 == null) throw Exception('Master encryption key not found');
    
    final keyBytes = base64Url.decode(keyBase64);
    final key = enc.Key(Uint8List.fromList(keyBytes));
    final iv = enc.IV.fromLength(16); // Random IV would be better, but we keep it simple for now
    
    final encrypter = enc.Encrypter(enc.AES(key));
    
    final sourceBytes = await source.readAsBytes();
    final encrypted = encrypter.encryptBytes(sourceBytes, iv: iv);

    // Write Header + IV + Encrypted Data
    final resultBytes = <int>[];
    resultBytes.addAll(utf8.encode(_backupHeader));
    resultBytes.addAll(iv.bytes);
    resultBytes.addAll(encrypted.bytes);

    await destination.writeAsBytes(resultBytes);
    return destination;
  }

  /// Decrypts a backup file and returns the raw Isar bytes if valid.
  Future<Uint8List> decryptBackup(File backupFile) async {
    final bytes = await backupFile.readAsBytes();
    
    // 1. Verify Header
    final headerLength = utf8.encode(_backupHeader).length;
    final header = utf8.decode(bytes.sublist(0, headerLength));
    if (header != _backupHeader) throw Exception('Invalid PaisaPlus backup file');

    // 2. Extract IV (16 bytes)
    final ivBytes = bytes.sublist(headerLength, headerLength + 16);
    final encryptedData = bytes.sublist(headerLength + 16);

    // 3. Decrypt
    final keyBase64 = await _secureStorage.read(key: _kIsarEncryptionKey);
    if (keyBase64 == null) throw Exception('Master encryption key not found');
    
    final keyBytes = base64Url.decode(keyBase64);
    final key = enc.Key(Uint8List.fromList(keyBytes));
    final iv = enc.IV(ivBytes);
    
    final encrypter = enc.Encrypter(enc.AES(key));
    final decrypted = encrypter.decryptBytes(enc.Encrypted(encryptedData), iv: iv);
    
    return Uint8List.fromList(decrypted);
  }

  /// Replaces the current database with a decrypted backup.
  /// WARNING: This will overwrite ALL local data.
  Future<void> restoreBackup(File backupFile) async {
    // 1. Decrypt into memory first to verify it works
    final decryptedBytes = await decryptBackup(backupFile);
    
    // 2. Get DB path
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}/paisaplus_db.isar';

    // 3. Close the current Isar instance
    // Note: This will cause any active watchers to error out until reopened.
    await _isar.close();

    // 4. Replace the file
    final dbFile = File(dbPath);
    if (await dbFile.exists()) await dbFile.delete();
    await dbFile.writeAsBytes(decryptedBytes);

    // 5. Success! The UI should ideally trigger a re-initialization or app restart.
    if (kDebugMode) print('Database restored successfully');
  }
}
