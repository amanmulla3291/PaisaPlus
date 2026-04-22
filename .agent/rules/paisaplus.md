# PaisaPlus — Project Bible
**Read before writing any code or making any architectural decision.**

## Identity
- Flutter mobile app (Android + iOS) | Flutter >=3.22.0 | Dart >=3.3.0 <4.0.0
- Goal: Premium, fully private, local-first expense tracker for India. Competes with Walnut, ET Money, YNAB — radically better in privacy and polish.

---

## NON-NEGOTIABLE RULES

**1. Local-First**: ALL financial data lives ONLY in encrypted Isar. Zero financial data ever sent to any server, cloud, or third party. No Firebase. No sync.

**2. Auth**: Strictly "Continue with Google" ONLY via `google_sign_in`. No email/password, no OTP. Supabase used ONLY for: JWT auth, user profile row, approval flag, device fingerprint hash.

**3. Backup**: Local encrypted `.enc` file only. No Google Drive, no Telegram, no cloud. Flow: `isar.copyToFile()` → AES-256 (`encrypt` package) → saved via `file_picker` to Downloads. Restore: pick `.enc` → decrypt → replace `default.isar` → soft restart. Monthly reminder via `flutter_local_notifications`.

**4. Admin Gate**: Same Google Sign-In for all users. Normal users → Pending Approval screen until approved. Admins → direct to Home. Admin panel revealed ONLY by long-pressing the AppBar logo. Only shown if `user.is_admin == true`.

**5. Device Binding (1-device)**: `flutter_udid` + `device_info_plus` → SHA-256 hash via `crypto` → stored in Supabase `profiles.device_fingerprint`. On every login, recompute and compare. Mismatch → force restore flow.

**6. UI (Kite-Level Polish)**: Full dark theme + Zerodha-red (`#EF4444`) accents. `Nunito` for money/numbers (bold). `Inter` for all UI text. `fl_chart` for all dashboards. `flutter_animate` for all transitions. No janky setState redraws.

**7. Onboarding**: 4-screen swipeable carousel, first launch only (flag in `shared_preferences`). Screen 1: Welcome & Privacy. Screen 2: Fast Tracking. Screen 3: Budgets & Insights. Screen 4: Security + "Continue with Google" button. Never shown again after completion.

**8. Other**: All features free forever. India-first defaults (INR, UPI, Rent, Fuel, EMI, Festival). Biometric lock (`local_auth`) + PIN fallback. No SMS auto-read. No AI scanner. Zero telemetry.

---

## EXACT PACKAGE VERSIONS (pubspec.yaml — do not change without instruction)

### UI
- `cupertino_icons: ^1.0.8`
- `flutter_animate: ^4.5.0` — use for ALL animations
- `fl_chart: ^0.69.0` — pie, line, bar charts
- `google_fonts: ^6.2.1` — Inter + Nunito

### State Management
- `flutter_riverpod: ^2.5.1` — **MANUAL SYNTAX ONLY. No code-gen.**
- NO `riverpod_generator`, `riverpod_annotation`, `riverpod_lint`, `custom_lint`

### Navigation
- `go_router: ^14.2.7` — shell routes for bottom nav

### Database
- `isar: ^3.1.0+1` — encrypted local NoSQL, single source of truth
- `isar_flutter_libs: ^3.1.0+1`
- NO `isar_generator` — schemas written manually (see constraint below)

### Auth & Backend
- `supabase_flutter: ^2.7.0` — auth + metadata ONLY
- `google_sign_in: ^6.2.1`

### Security
- `flutter_secure_storage: ^9.2.2` — stores Isar key, never leaves device
- `encrypt: ^5.0.3` — AES-256-CBC for backup encryption
- `local_auth: ^2.3.0` — biometric + PIN fallback
- `crypto: ^3.0.3` — SHA-256 for device fingerprint

### Device Identity
- `flutter_udid: ^3.0.0`
- `device_info_plus: ^11.1.0`

### Files & Notifications
- `path_provider: ^2.1.3`
- `file_picker: ^8.1.2`
- `flutter_local_notifications: ^18.0.1` — local only, no push

### Utilities
- `shared_preferences: ^2.3.2` — onboarding flags only
- `intl: ^0.19.0` — INR formatting (`NumberFormat.currency(locale:'en_IN')`)
- `uuid: ^4.4.2` — IDs for Isar records
- `collection: ^1.18.0`

### Dev Only
- `flutter_lints: ^4.0.0`
- `flutter_launcher_icons: ^0.14.3` (source: `assets/icons/icon.png`)

---

## CRITICAL DEPENDENCY CONSTRAINT

isar_generator 3.x requires analyzer <6.0.0
riverpod_generator requires analyzer ^6.x+
These are INCOMPATIBLE — never add both.

Resolution: `isar_generator` removed, schemas hand-written. All riverpod code-gen packages removed, manual provider syntax only. Before adding ANY dev dependency, check its `analyzer` version requirement.

---

## RIVERPOD MANUAL SYNTAX (no annotations, no .g.dart files)

```dart
// Correct — StateNotifier
class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]);
}
final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>(
  (ref) => TransactionNotifier(),
);

// Correct — AsyncNotifier
class ProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override Future<UserProfile?> build() async => ...;
}
final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserProfile?>(ProfileNotifier.new);

// NEVER: @riverpod, @Riverpod(), build_runner, generated .g.dart files
```

---

## FOLDER STRUCTURE

```
lib/
├── core/
│   ├── supabase/        # client init, auth service
│   ├── isar/            # instance init, manual schema models
│   ├── services/        # BackupService, NotificationService, DeviceService
│   └── security/        # EncryptionService, BiometricService
├── features/
│   ├── auth/            # Splash, Onboarding, GoogleSignIn, PendingApproval
│   ├── home/            # Dashboard, KPI cards, charts
│   ├── transactions/    # List, QuickAdd FAB (calculator), filters
│   ├── budgets/         # Envelope budgeting, progress
│   ├── reports/         # Analytics, trends, insights
│   └── more/            # Settings, Backup, Biometrics, Admin (gesture-gated)
├── shared/
│   ├── widgets/
│   ├── theme/           # AppTheme, AppColors (red=#EF4444), AppTextStyles
│   └── extensions/
└── utils/
```

---

## APP FLOW

Splash → [first launch?] → 4-Screen Onboarding → Google Sign-In
      → Device fingerprint check
      → is_admin?  → Home (direct)
      → approved?  → First-Time Setup → Home
      → else       → Pending Approval Screen

Returning approved users: Splash → silent auth refresh → Home.

---

## ISAR SCHEMA RULES (no generator)
- All IDs are `int` (Isar auto-increment or UUID-derived).
- Use `@Index()` on frequently queried fields (`date`, `categoryId`, `accountId`).
- `AppSettings` is single-row (id = 1) for global config.
- Core collections: `Transaction`, `Category`, `Account`, `Budget`, `Goal`, `Loan`, `Subscription`, `RecurringRule`, `AppSettings`, `Tag`, `Person`.

---

## PHASE ORDER
1. **Foundation**: Encrypted Isar, Supabase Google Sign-In, device binding, Pending screen, Admin gesture, Kite theme, onboarding, GoRouter shell.
2. **Core**: Quick-add FAB (calculator), transaction list, home dashboard (fl_chart).
3. **Premium Features**: Budgets, goals, loans, recurring transactions, subscriptions.
4. **Analytics**: Reports, trends, monthly insights, fl_chart breakdowns.
5. **Polish**: Backup/restore, biometric lock, notifications, admin panel UI, India defaults.

---

## ASSETS
- `assets/fonts/` → Inter (400/500/600/700) + Nunito (400/700/800)
- `assets/images/` → onboarding illustrations
- `assets/icons/` → icon.png (launcher source)
- `assets/animations/` → Lottie/Rive files

Typography: `Nunito` for money display. `Inter` for everything else.

---

## INDIA-FIRST DEFAULTS
- Currency: INR, symbol `₹`, locale `en_IN`
- Accounts: Cash, Bank, UPI, Credit Card, Savings
- Categories: Groceries, Fuel, Rent, EMI, Dining, Medical, Festival, Utilities, Transport
- Festival budget templates: Diwali, Holi, Navratri

---
*Single source of truth. When in doubt: privacy, performance, Kite-level polish.*
