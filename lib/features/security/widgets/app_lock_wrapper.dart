import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import '../../../core/isar/isar_service.dart';
import '../../../core/isar/models/app_settings.dart';
import '../../../shared/theme/app_colors.dart';

class AppLockWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const AppLockWrapper({super.key, required this.child});

  @override
  ConsumerState<AppLockWrapper> createState() => _AppLockWrapperState();
}

class _AppLockWrapperState extends ConsumerState<AppLockWrapper>
    with WidgetsBindingObserver {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isLocked = false;
  bool _isInactive = false;
  bool _hasCheckedInitial = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Sync check if provider already has data (unlikely on cold start but good practice)
    final settings = ref.read(appSettingsProvider).valueOrNull;
    if (settings != null) {
      _isLocked = settings.biometricEnabled;
      _hasCheckedInitial = true;
      if (_isLocked) _authenticate();
    } else {
      _checkInitialLock();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _checkInitialLock() async {
    try {
      final settings = await ref.read(appSettingsProvider.future);
      if (settings.biometricEnabled) {
        setState(() {
          _isLocked = true;
          _hasCheckedInitial = true;
        });
        _authenticate();
      } else {
        setState(() => _hasCheckedInitial = true);
      }
    } catch (e) {
      // Fallback: if settings fail to load, allow entry but log error
      debugPrint('Settings load error in lock: $e');
      setState(() => _hasCheckedInitial = true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.hidden) {
      setState(() => _isInactive = true);
    } else if (state == AppLifecycleState.paused) {
      _handleBackground();
    } else if (state == AppLifecycleState.resumed) {
      setState(() => _isInactive = false);
      _handleForeground();
    }
  }

  void _handleBackground() async {
    final settings = await ref.read(appSettingsProvider.future);
    if (settings.biometricEnabled) {
      setState(() => _isLocked = true);
    }
  }

  void _handleForeground() {
    if (_isLocked) {
      _authenticate();
    }
  }

  Future<void> _authenticate() async {
    try {
      final authenticated = await _auth.authenticate(
        localizedReason: 'Please authenticate to unlock PaisaPlus',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allow PIN/Pattern fallback
        ),
      );

      if (authenticated) {
        setState(() => _isLocked = false);
      }
    } catch (e) {
      debugPrint('Auth error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // If we haven't even checked if we SHOULD lock yet, obscure everything to be safe.
    final showOverlay = !_hasCheckedInitial || _isLocked || _isInactive;

    return Stack(
      children: [
        // Always build child to maintain state, but potentially obscure it
        widget.child,
        if (showOverlay)
          Positioned.fill(
            child: Material(
              color: AppColors.background,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline_rounded,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'PaisaPlus Locked',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (_isLocked) ...[
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: _authenticate,
                        icon: const Icon(Icons.fingerprint_rounded),
                        label: const Text('Unlock'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
