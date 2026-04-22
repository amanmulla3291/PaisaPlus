// lib/core/security/device_binding_service.dart
// ─────────────────────────────────────────────────────────────────────────────
// Device binding — 1-device-per-account enforcement.
// Computes a stable SHA-256 fingerprint from flutter_udid + device_info.
// Only the HASH is stored in Supabase. Raw identifiers never leave the device.
//
// SECURITY FIX — TOCTOU (Time-of-Check to Time-of-Use) Race Condition:
//
//   Original code:
//     1. SELECT device_fingerprint FROM profiles WHERE id = userId
//     2. IF fingerprint is null → UPDATE profiles SET fingerprint = computed
//
//   Problem: Steps 1 and 2 are not atomic. If a user authenticates on two
//   devices simultaneously — e.g. reinstalling the app while an old session
//   is active — both sessions could read `null` from step 1, then both
//   proceed to step 2 and each bind a different fingerprint. Whichever write
//   lands last wins, and the first device is now silently unbound.
//
//   Fix: Replaced the SELECT → conditional UPDATE pattern with a single
//   atomic SQL upsert using a conflict target on the primary key with a
//   DO NOTHING on conflict for the fingerprint column. This is implemented
//   via a Postgres function called `bind_device_if_unbound` that:
//     - Inserts the row with fingerprint if it doesn't exist (first bind)
//     - Does nothing if device_fingerprint is already set (idempotent)
//     - Returns the CURRENT fingerprint so we can compare on the client
//   All of this happens in one round-trip, under a row-level lock.
//
//   The SQL function to create in Supabase:
//
//     CREATE OR REPLACE FUNCTION bind_device_if_unbound(
//       p_user_id  UUID,
//       p_email    TEXT,
//       p_fp       TEXT
//     )
//     RETURNS TEXT
//     LANGUAGE plpgsql
//     SECURITY DEFINER
//     AS $$
//     DECLARE
//       v_stored TEXT;
//     BEGIN
//       -- Insert row if it doesn't exist yet (first ever sign-in)
//       INSERT INTO profiles (id, email, device_fingerprint)
//       VALUES (p_user_id, p_email, p_fp)
//       ON CONFLICT (id) DO NOTHING;
//
//       -- Atomically set fingerprint only if currently NULL
//       UPDATE profiles
//       SET    device_fingerprint = p_fp
//       WHERE  id = p_user_id
//         AND  (device_fingerprint IS NULL OR device_fingerprint = '');
//
//       -- Return whatever is stored now (may be p_fp or a different device's fp)
//       SELECT device_fingerprint
//       INTO   v_stored
//       FROM   profiles
//       WHERE  id = p_user_id;
//
//       RETURN v_stored;
//     END;
//     $$;
//
//     -- Grant execute to authenticated role so RLS is respected
//     GRANT EXECUTE ON FUNCTION bind_device_if_unbound TO authenticated;
//
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum DeviceBindingStatus { bound, firstBind, mismatch, error }

class DeviceBindingResult {
  final DeviceBindingStatus status;
  final String? fingerprint;
  final String? message;

  const DeviceBindingResult({
    required this.status,
    this.fingerprint,
    this.message,
  });
}

class DeviceBindingService {
  /// Computes a stable SHA-256 fingerprint for this device.
  /// The raw UDID and device identifiers are never stored or transmitted —
  /// only the resulting hash is sent to Supabase.
  Future<String> computeFingerprint() async {
    final udid = await FlutterUdid.udid;
    final deviceInfo = DeviceInfoPlugin();
    String deviceSalt = '';

    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = await deviceInfo.androidInfo;
      deviceSalt = '${android.model}_${android.brand}_${android.hardware}';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = await deviceInfo.iosInfo;
      deviceSalt = '${ios.model}_${ios.identifierForVendor}';
    }

    final raw = 'paisaplus_${udid}_$deviceSalt';
    final bytes = utf8.encode(raw);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Checks and binds the device fingerprint atomically.
  ///
  /// Uses a single Postgres RPC call (`bind_device_if_unbound`) instead of
  /// a SELECT → conditional UPDATE. The RPC is atomic under a row-level lock,
  /// eliminating the TOCTOU race present in the original implementation.
  ///
  /// See the SQL function definition in the file header above.
  /// Run it once in Supabase SQL editor before deploying this version.
  Future<DeviceBindingResult> checkAndBind(String userId) async {
    try {
      final fingerprint = await computeFingerprint();
      final client = Supabase.instance.client;
      final email = client.auth.currentUser?.email ?? '';

      // Single atomic RPC — no SELECT + UPDATE race possible.
      final storedFingerprint = await client.rpc(
        'bind_device_if_unbound',
        params: {
          'p_user_id': userId,
          'p_email': email,
          'p_fp': fingerprint,
        },
      ) as String?;

      if (storedFingerprint == null || storedFingerprint.isEmpty) {
        // Row existed but fingerprint was null and our UPDATE set it
        return DeviceBindingResult(
          status: DeviceBindingStatus.firstBind,
          fingerprint: fingerprint,
          message: 'Device successfully bound to your account.',
        );
      }

      if (storedFingerprint == fingerprint) {
        // Happy path — this device is the bound device
        return DeviceBindingResult(
          status: DeviceBindingStatus.bound,
          fingerprint: fingerprint,
        );
      }

      // A different fingerprint is stored — this is a different device
      debugPrint(
        '[PaisaPlus] Device mismatch. '
        'Stored: ${storedFingerprint.substring(0, 8)}... '
        'Current: ${fingerprint.substring(0, 8)}...',
      );
      return DeviceBindingResult(
        status: DeviceBindingStatus.mismatch,
        fingerprint: fingerprint,
        message: 'This account is bound to another device. '
            'Please restore your backup on this device to regain access.',
      );
    } on PostgrestException catch (e) {
      debugPrint('[PaisaPlus] Device binding PostgrestException: ${e.message}');
      return const DeviceBindingResult(
        status: DeviceBindingStatus.error,
        message: 'Device verification failed. Please check your connection.',
      );
    } catch (e) {
      debugPrint('[PaisaPlus] Device binding unexpected error: $e');
      return const DeviceBindingResult(
        status: DeviceBindingStatus.error,
        message: 'Unable to verify device. Please check your connection.',
      );
    }
  }
}

final deviceBindingServiceProvider = Provider<DeviceBindingService>((ref) {
  return DeviceBindingService();
});