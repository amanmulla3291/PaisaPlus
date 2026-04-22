// lib/core/isar/providers/loan_providers.dart
// ─────────────────────────────────────────────────────────────────────────────
// Riverpod providers for the Loans & Debts feature.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_providers.dart';
import '../schemas/loan.dart';

/// Watches active borrowed loans (debts).
final activeBorrowedLoansProvider = FutureProvider<List<Loan>>((ref) async {
  ref.watch(watchLoansProvider);
  final service = await ref.watch(loanServiceProvider.future);
  return service.getActiveBorrowed();
});

/// Watches active lent loans (assets).
final activeLentLoansProvider = FutureProvider<List<Loan>>((ref) async {
  ref.watch(watchLoansProvider);
  final service = await ref.watch(loanServiceProvider.future);
  return service.getActiveLent();
});

/// Watches total outstanding debt (borrowed).
final totalOwedProvider = FutureProvider<int>((ref) async {
  ref.watch(watchLoansProvider);
  final service = await ref.watch(loanServiceProvider.future);
  return service.getTotalOwed();
});

/// Watches total outstanding lent amount.
final totalLentProvider = FutureProvider<int>((ref) async {
  ref.watch(watchLoansProvider);
  final service = await ref.watch(loanServiceProvider.future);
  return service.getTotalLent();
});
