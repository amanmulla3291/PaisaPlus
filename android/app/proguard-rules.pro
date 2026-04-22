# ─────────────────────────────────────────────────────────────────────────────
# android/app/proguard-rules.pro  —  PaisaPlus
# ─────────────────────────────────────────────────────────────────────────────

# ── Flutter & Dart ────────────────────────────────────────────────────────────
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# ── Isar (CRITICAL — must keep all Isar generated classes) ───────────────────
# Isar uses reflection internally for its native bridge.
-keep class dev.isar.** { *; }
-keep class com.isar.** { *; }
-keepclassmembers class * {
    @dev.isar.annotations.** *;
}
# Keep all Isar schema classes (generated with @Collection annotation)
-keep class com.paisaplus.** { *; }

# ── flutter_secure_storage ────────────────────────────────────────────────────
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# ── Google Sign-In ────────────────────────────────────────────────────────────
-keep class com.google.android.gms.** { *; }
-keep interface com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# ── Supabase / OkHttp / Ktor ─────────────────────────────────────────────────
-dontwarn okhttp3.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okio.**

# ── Kotlin Coroutines ─────────────────────────────────────────────────────────
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keepclassmembers class kotlinx.coroutines.** {
    volatile <fields>;
}

# ── Local Notifications ───────────────────────────────────────────────────────
-keep class com.dexterous.** { *; }

# ── Encrypt / BouncyCastle (AES-256 backup encryption) ───────────────────────
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**
-keep class com.sun.crypto.** { *; }

# ── device_info_plus ─────────────────────────────────────────────────────────
-keep class dev.fluttercommunity.plus.device_info.** { *; }

# ── General rules ─────────────────────────────────────────────────────────────
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
