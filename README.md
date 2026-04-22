# 💸 PaisaPlus

**PaisaPlus** is a premium, privacy-first, and local-first expense tracker designed for users who want complete control over their financial data without sacrificing modern cloud features.

## ✨ Key Features

- **🛡️ Privacy-First Architecture**: Your financial data (transactions, notes, amounts) never leaves your device.
- **🚀 Local-First Performance**: Powered by **Isar NoSQL**, the app works instantly even without an internet connection.
- **🔐 Secure Backups**: Automatic, AES-256 encrypted local backups to protect against data loss.
- **☁️ Metadata-Only Sync**: Synchronize your accounts and categories across devices via **Supabase** while keeping all financial values strictly local (**DataGhosting**).
- **🎨 Premium UI/UX**: A sleek, dark-themed interface built with **Riverpod** and **GoRouter** for a smooth, app-like experience.
- **💎 App Lock**: Secure your data with biometric (Fingerprint/FaceID) or PIN protection.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **Database**: [Isar](https://isar.dev) (High-performance NoSQL)
- **State Management**: [Riverpod](https://riverpod.dev)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Backend/Auth**: [Supabase](https://supabase.com)
- **Environment**: [Flutter Dotenv](https://pub.dev/packages/flutter_dotenv)

---

## 🚀 Getting Started

### 1. Prerequisites
- Flutter SDK (Stable channel)
- Android Studio / Xcode

### 2. Environment Configuration
PaisaPlus uses a local `.env` file for sensitive configuration. 
1. Copy the template:
   ```bash
   cp .env.template .env
   ```
2. Fill in your credentials in the `.env` file:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
   - `GOOGLE_WEB_CLIENT_ID`

### 3. Run the App
```bash
flutter pub get
flutter run
```

---

## 🏗️ CI/CD & Releases

This project is equipped with a fully automated **GitHub Actions** pipeline ([build_release.yml](.github/workflows/build_release.yml)):
- **Android**: Builds release APKs split per ABI and signs them automatically.
- **iOS**: Builds release-ready zipped builds.
- **Auto-Release**: Every push to `main` creates a new tagged release on GitHub.

---

## 📜 Security Model

PaisaPlus implements a "Ghost Sync" strategy:
1. **Local**: All Transactions, Budgets, and Loans.
2. **Cloud (Encrypted)**: Only Account names and Category metadata.
3. **Ghosting**: The sync engine explicitly filters out `amount`, `notes`, and `date` fields before uploading metadata to the cloud, ensuring your net worth is invisible even to the cloud provider.

---

Developed with ❤️ by **Aman Mulla**
