# CLAUDE.md - PaisaPlus Project Bible

**Project Name**: PaisaPlus  
**Type**: Flutter Mobile App (Android + iOS)  
**Goal**: Build a premium, fully private, local-first expense tracker that competes with Walnut, Money Manager, Spendee, ET Money, YNAB, etc. in 2026 while being radically better in privacy and polish.

## Non-Negotiable Rules (Never Break These)

1. **100% Local-First**
   - All financial data (transactions, budgets, categories, goals, loans, subscriptions, etc.) lives **only** in encrypted Isar database.
   - No real-time cloud sync, no Firebase/Firestore for user data.

2. **Authentication**
   - Strictly "Continue with Google" only. No email/password, no phone OTP as primary.
   - Supabase is used **only** for Authentication + minimal metadata (profile, approval status, device fingerprint).
   - Zero financial data is ever sent to Supabase.

3. **Backup & Restore**
   - Fully local encrypted backup only (.enc file saved to phone storage).
   - No Telegram, no Google Drive upload, no cloud backup service.
   - Monthly local notification reminder (user can set interval: 1/3/6/12 months).
   - Backup uses Isar.copyToFile() → AES-256 encryption → saved via file_picker/path_provider.
   - Restore: User picks .enc file → decrypt → replace Isar file → soft restart.

4. **Admin Gate & Exclusivity**
   - Both admin and normal users use the same Google Sign-In.
   - Normal users see a Pending Approval screen until approved.
   - Admins skip Pending screen and go directly to Home.
   - Admin panel is accessed by **long-pressing the app logo** (top-left in AppBar) anywhere in the app. Only visible if user.is_admin == true.

5. **Device Binding (1-Device Policy)**
   - Use flutter_udid + device_info_plus to create a stable device_fingerprint.
   - Store only the hash in Supabase profiles table.
   - On every login, recompute fingerprint and compare. Mismatch → force restore from backup.

6. **UI/UX Philosophy**
   - Kite-level fintech polish: Dark theme with Zerodha-red accents.
   - Bold numbers for money amounts.
   - Smooth fl_chart dashboards.
   - Bottom navigation: Home | Transactions | Budgets | Reports | More
   - Persistent red Floating Action Button (FAB) for quick transaction entry (calculator-style like Kite).

7. **Onboarding**
   - 4-screen carousel **before** Google Sign-In screen (only on first launch).
   - Screen 1: Welcome & Privacy USP
   - Screen 2: Simple & Fast Tracking
   - Screen 3: Smart Budgeting & Insights
   - Screen 4: Privacy, Security & Exclusive Access (ends with "Continue with Google" button)

8. **Other Rules**
   - All "premium" features are free forever.
   - India-first defaults (UPI, festival budgets, common categories).
   - Biometric lock + PIN fallback.
   - No bank SMS auto-read, no AI receipt scanner (keep lightweight and private).

## Tech Stack
- Flutter (latest stable)
- Isar 4.x (encrypted)
- Supabase Flutter SDK (auth only)
- Riverpod 2.0 (with riverpod_annotation)
- GoRouter
- fl_chart
- flutter_secure_storage
- encrypt (AES-256)
- file_picker + path_provider
- flutter_local_notifications
- google_sign_in
- flutter_udid + device_info_plus

## Folder Structure
Use standard clean architecture:
- core/ (supabase, isar, services, security)
- features/ (auth, home, transactions, budgets, reports, more)
- shared/ (widgets, theme, extensions)
- utils/

## Current App Flow Summary
1. Splash → 4-screen Onboarding (first launch only) → Google Sign-In
2. Post Google Sign-In → Device binding check
3. Normal user → Pending Approval screen (until admin approves)
4. Admin → Direct to Home
5. After approval → Minimal first-time setup (currency, initial accounts, biometric)
6. Main App: Bottom nav + red FAB

## Phase Implementation Order
**Phase 1**: Foundation & Auth (Supabase, Device Binding, Pending Screen, Admin long-press, Isar encrypted, Kite theme, 4-screen onboarding)
**Phase 2**: Core Transactions + Dashboard
**Phase 3**: Budgets, Goals, Recurring, Loans, Subscriptions
**Phase 4**: Reports & Analytics (fl_chart)
**Phase 5**: Local Backup/Restore, Biometrics, Notifications, Admin Panel UI, Polish

## Security Checklist (Must Always Pass)
- Isar encryption key never leaves device
- Backup encryption key never leaves device
- No financial data sent to any server
- Device fingerprint prevents multi-device use
- Admin panel hidden behind gesture

---

**Instruction to Claude**:  
You are now the lead architect and senior Flutter developer for PaisaPlus. Every response and every line of code you generate must strictly follow the rules and architecture defined in this file. When in doubt, prioritize privacy, performance, and Kite-level polish. Always refer back to this CLAUDE.md as the single source of truth.