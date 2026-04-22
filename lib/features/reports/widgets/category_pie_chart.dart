// lib/features/reports/widgets/category_pie_chart.dart
// ─────────────────────────────────────────────────────────────────────────────
// Premium Donut chart showing expense breakdown by category.

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/reports_providers.dart';
import '../../../core/isar/providers/service_providers.dart';
import '../../../shared/theme/app_colors.dart';

class CategoryPieChart extends ConsumerWidget {
  final DateTime month;

  const CategoryPieChart({super.key, required this.month});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spendingAsync = ref.watch(categorySpendingProvider(month));
    final categoriesAsync = ref.watch(watchExpenseCategoriesProvider);
    final isPrivate = ref.watch(privacyModeProvider);

    return spendingAsync.when(
      loading: () => _shimmer(),
      error: (e, __) => const SizedBox.shrink(),
      data: (spending) {
        if (spending.isEmpty) return _buildEmpty();

        final total = spending.values.fold<int>(0, (a, b) => a + b);
        final formatter = NumberFormat('#,##,##0', 'en_IN');

        return Container(
          height: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              const Text(
                'Spending Breakdown',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 60,
                        startDegreeOffset: -90,
                        sections: _buildSections(spending, categoriesAsync.asData?.value ?? []),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textTertiary,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            isPrivate ? '••••' : '₹${formatter.format(total / 100)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _buildSections(Map<int, int> spending, List<dynamic> categories) {
    final sortedEntries = spending.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Show top 5, group rest as "Other"
    final top5 = sortedEntries.take(5).toList();
    final othersTotal = sortedEntries.length > 5 
        ? sortedEntries.skip(5).fold<int>(0, (sum, e) => sum + e.value)
        : 0;

    final sections = <PieChartSectionData>[];

    for (final entry in top5) {
      final cat = categories.firstWhere((c) => c.id == entry.key, orElse: () => null);
      sections.add(
        PieChartSectionData(
          value: entry.value.toDouble(),
          color: Color(cat?.colorValue ?? 0xFF9E9E9E),
          radius: 30,
          showTitle: false,
          badgeWidget: _Badge(
            iconData: IconData(cat?.iconCodePoint ?? Icons.circle.codePoint, fontFamily: 'MaterialIcons'),
            color: Color(cat?.colorValue ?? 0xFF9E9E9E),
          ),
          badgePositionPercentageOffset: 0.98,
        ),
      );
    }

    if (othersTotal > 0) {
      sections.add(
        PieChartSectionData(
          value: othersTotal.toDouble(),
          color: AppColors.textTertiary,
          radius: 25,
          showTitle: false,
        ),
      );
    }

    return sections;
  }

  Widget _buildEmpty() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: const Text('No spending data for this month', style: TextStyle(color: AppColors.textTertiary)),
    );
  }

  Widget _shimmer() => Container(height: 300, color: AppColors.surface);
}

class _Badge extends StatelessWidget {
  final IconData iconData;
  final Color color;

  const _Badge({required this.iconData, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Icon(iconData, size: 14, color: color),
    );
  }
}
