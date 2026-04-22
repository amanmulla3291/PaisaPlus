**✅ Theoretical Implementation Plan for PaisaPlus**  
**Version: April 2026 – Fully Local-First Expense Tracker**  
**Target Audience**: Claude (or any senior Flutter architect)  
**Purpose**: This is a **theoretical blueprint** — not a code checklist. It explains **why** every architectural decision was made, the philosophy behind the app, the exact constraints, the mental model of every major subsystem, and how the pieces fit together. Read this first before writing any code. It will help you make correct, secure, and maintainable decisions even when edge cases arise.

### 1. Core Philosophy & Non-Negotiable Rules
PaisaPlus must compete with Walnut, Spendee, Money Manager, ET Money, YNAB, etc. in 2026 **while being radically different** in three ways:
- **Privacy-first**: 100% local storage. Zero financial data ever leaves the device except in a user-initiated, encrypted local backup file.
- **Exclusive & Controlled**: Admin-approval gate + 1-device binding.
- **Kite-level Polish**: Fintech-grade dark UI with Zerodha-red accents, buttery-smooth performance, bold numbers, fl_chart dashboards — no other fully-local app matches this feel.

**Hard Rules (Never Break These)**:
- All transactions, budgets, categories, goals, loans, etc. live **only** in encrypted Isar.
- Supabase is used **only** for authentication + tiny metadata (profile, approval status, device fingerprint). No financial data, no backups, no real-time sync.
- Backup = fully local encrypted `.enc` file saved to user’s phone storage. No cloud upload of any kind.
- Monthly local notification reminder only.
- Admin and normal users share the same login flow, but admins bypass Pending screen and unlock hidden admin panel via long-press on top-left logo.
- Device binding is strict (one device per account).

### 2. High-Level Architecture (Mental Model)

```
User → Supabase Auth (JWT) → App
                     ↓
               Device Binding Check
                     ↓
               Isar (encrypted DB) ←→ Riverpod Providers
                     ↓
               UI Layer (GoRouter + Material You Dark Theme)
                     ↓
               Local Backup Service (AES-256 snapshot)
```

- **Presentation Layer**: GoRouter + Riverpod 2.0 (notifiers + providers) + custom widgets.
- **Data Layer**: Isar (schema-first, encrypted) + dedicated Service classes.
- **Auth Layer**: Supabase Flutter SDK (minimal wrapper).
- **Security Layer**: `flutter_secure_storage` + `encrypt` package + biometric-derived keys.
- **State**: Riverpod for instant reactive UI updates (no setState anywhere).

### 3. Security & Privacy Model (The Real USP)
- **Isar Encryption**: Key stored in `flutter_secure_storage`. Key is generated once on first launch and never leaves the device. Use biometric auth to derive/validate the key when possible.
- **Backup Encryption**: Same key (or optional user-provided password layered on top). Backup is a raw snapshot of the Isar file → AES-256 encrypted → saved as `.enc`.
- **Device Binding**: On first successful login we compute a stable `device_fingerprint` (FlutterUdid + device_info_plus hash). Store **only the hash** in Supabase `profiles.device_fingerprint`. Every future login recomputes and compares. Mismatch = “Account bound to another device — restore backup on this device.”
- **Admin Access**: Purely client-side gesture (GestureDetector long-press on AppBar logo). The `is_admin` flag comes from Supabase profile (RLS-protected). Normal users never see the admin panel.
- **No Telemetry**: No Firebase Analytics, no Sentry, no third-party tracking.

### 4. Data Layer – Isar (The Single Source of Truth)
All models live in one encrypted Isar instance:
- `Transaction`, `Category`, `Account`, `Budget`, `Goal`, `Loan`, `Subscription`, `RecurringRule`, `AppSettings`, `Achievement`, `Tag`, `Person`, etc.
- Use Isar’s embedded objects and links for relationships (no joins needed).
- `AppSettings` collection holds: last_backup_date, backup_interval_months, currency, etc.
- All queries are offline, sub-second even with 10k+ records (Isar is blazing fast).

### 5. Authentication & User Management Flow (Theoretical)
1. User opens app → Supabase auth screen (email/password + Phone OTP for India).
2. Successful sign-in → fetch `profiles` row (RLS ensures only own row).
3. **If admin** (`is_admin == true`): Skip pending → go to Home.
4. **If normal user**:
   - If `approved == false` → show beautiful Pending Approval screen.
   - If approved → proceed to Home.
5. Device fingerprint check runs silently after every auth.
6. Long-press on top-left logo (AppBar) anywhere in the app:
   - If `is_admin` → open AdminPanel (modal or route) with user management, approval list, device binding overview.

### 6. Backup & Restore – Fully Local (Detailed Theory)
**Goal**: User-controlled, zero-friction, zero-cloud.

- **Create Backup**:
  1. User taps “Backup Now” in Settings.
  2. Optional custom password dialog.
  3. Briefly close Isar instance.
  4. `isar.copyToFile()` → temporary snapshot.
  5. Read bytes → AES-256 encrypt (key from secure_storage + optional user password).
  6. Use `path_provider` + `file_picker` (save dialog) → default to Downloads folder.
  7. Filename: `PaisaPlus_Backup_YYYY-MM-DD_HH-MM.enc`.
  8. Update `AppSettings.last_backup_date`.

- **Restore**:
  1. User selects `.enc` file via `file_picker`.
  2. Decrypt (ask for password if used).
  3. Close current Isar (`isar.close(deleteFromDisk: true)`).
  4. Copy decrypted file to Isar directory as `default.isar`.
  5. Re-open Isar instance.
  6. Soft restart (Restart.restartApp() or full Navigator reset).

- **Reminder Logic** (local only):
  - On every app open: calculate months passed vs user-chosen interval (1/3/6/12).
  - If due → `flutter_local_notifications` banner + notification.
  - User can change interval in Settings.

### 7. UI/UX & Navigation Theory (Kite-Level)
- **Theme**: Full dark + Material You + Zerodha-red accents. Bold typography for money amounts.
- **Navigation**: GoRouter with bottom navigation (Home | Transactions | Budgets | Reports | More).
- **FAB**: Persistent red floating action button → quick transaction entry (calculator pad exactly like Kite).
- **Home Dashboard**: Bold balance, three KPI cards, fl_chart pie + line, upcoming items.
- **List screens**: Virtualized, swipe actions, advanced filters.
- **Admin Gesture**: Always available on AppBar logo — feels exclusive.

### 8. State Management Theory
- Riverpod 2.0 (providers + notifiers + riverpod_annotation).
- Every screen has its own dedicated provider family where needed.
- Instant UI updates when transaction is added (no manual refresh).
- Global providers for: currentUserProfile, isarInstance, theme, etc.

### 9. Phase-by-Phase Theoretical Roadmap (Why this order?)

**Phase 1 – Foundation & Auth**  
Build the security skeleton first. Everything else depends on encrypted Isar + correct auth flow + device binding. Include basic theme and navigation shell.

**Phase 2 – Core Transactions & Dashboard**  
Daily-use heart of the app. Get quick-add + list + charts rock-solid before adding complexity.

**Phase 3 – Premium Features**  
Budgets, Goals, Loans, Recurring, Subscriptions, Bill splitting. These are what make it “premium” in competitors.

**Phase 4 – Analytics & Reports**  
Heavy Isar queries + fl_chart. Insights generated from local data only.

**Phase 5 – Backup, Security & Polish**  
Local backup/restore + biometrics + notifications + widgets + admin panel UI + India defaults.

**Final Polish Phase**  
Performance tuning (large datasets), animations, accessibility, testing, release assets.

### 10. Edge Cases & Mitigations (Think Ahead)
- App killed during backup → safe because Isar copy is atomic.
- Device change → fingerprint mismatch → force restore flow.
- Isar corruption → user can always restore from their last .enc file.
- Biometric not available → fallback to PIN.
- Very large DB (50k+ records) → Isar still handles it; test queries stay fast.
- Multi-currency → store everything in base INR internally, display converted.
