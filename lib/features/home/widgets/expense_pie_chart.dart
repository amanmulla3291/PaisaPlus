// lib/features/home/widgets/expense_pie_chart.dart
//
// PaisaPlus – Expense Pie Chart (fl_chart donut)
// ------------------------------------------------
// Shows spending by category for the selected month as a donut chart.
// Tapping a segment highlights it and shows the category name + amount
// in the centre hole.
//
// Data: monthlyExpensesByCategoryProvider(month) → Map<categoryId, paise>
// Category name/colour: loaded from categoryServiceProvider in a second pass.
//
// Empty state: shown when no expenses this month.
// "Other" bucket: categories < 2% of total are grouped into "Other".

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../core/isar/services/category_service.dart';
import '../../../shared/theme/app_colors.dart';

class ExpensePieChart extends ConsumerStatefulWidget {
  final DateTime selectedMonth;

  const ExpensePieChart({super.key, required this.selectedMonth});

  @override
  ConsumerState<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends ConsumerState<ExpensePieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final categoryBreakdownAsync =
        ref.watch(monthlyExpensesByCategoryProvider(widget.selectedMonth));
    final categoryServiceAsync = ref.watch(categoryServiceProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: categoryBreakdownAsync.when(
        loading: () => const _ChartShimmer(),
        error: (_, __) => const SizedBox(height: 200),
        data: (breakdown) {
          if (breakdown.isEmpty) {
            return const _EmptyChart();
          }

          return categoryServiceAsync.when(
            loading: () => const _ChartShimmer(),
            error: (_, __) => const SizedBox(height: 200),
            data: (catService) {
              return _AsyncCategoryChart(
                breakdown: breakdown,
                catService: catService,
                touchedIndex: _touchedIndex,
                onTouch: (index) => setState(() => _touchedIndex = index),
              );
            },
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Chart that resolves category names from service
// ─────────────────────────────────────────────────────────────────────────────

class _AsyncCategoryChart extends StatefulWidget {
  final Map<int, int> breakdown;
  final CategoryService catService;
  final int touchedIndex;
  final ValueChanged<int> onTouch;

  const _AsyncCategoryChart({
    required this.breakdown,
    required this.catService,
    required this.touchedIndex,
    required this.onTouch,
  });

  @override
  State<_AsyncCategoryChart> createState() => _AsyncCategoryChartState();
}

class _AsyncCategoryChartState extends State<_AsyncCategoryChart> {
  List<_ChartSegment> _segments = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadSegments();
  }

  @override
  void didUpdateWidget(_AsyncCategoryChart old) {
    super.didUpdateWidget(old);
    if (old.breakdown != widget.breakdown) {
      _loadSegments();
    }
  }

  Future<void> _loadSegments() async {
    final total =
        widget.breakdown.values.fold<int>(0, (a, b) => a + b);
    if (total == 0) return;

    final segments = <_ChartSegment>[];
    int colorIndex = 0;
    int otherPaise = 0;

    // Sort by amount desc
    final sorted = widget.breakdown.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in sorted) {
      final pct = entry.value / total;
      if (pct < 0.02 && sorted.length > 5) {
        otherPaise += entry.value;
        continue;
      }

      final cat = await widget.catService.getById(entry.key);
      segments.add(_ChartSegment(
        name: cat?.name ?? 'Unknown',
        paise: entry.value,
        color: cat != null
            ? Color(cat.colorValue)
            : AppColors.chartColors[colorIndex % AppColors.chartColors.length],
        percentage: pct,
      ));
      colorIndex++;
    }

    if (otherPaise > 0) {
      segments.add(_ChartSegment(
        name: 'Other',
        paise: otherPaise,
        color: AppColors.textTertiary,
        percentage: otherPaise / total,
      ));
    }

    if (mounted) {
      setState(() {
        _segments = segments;
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const _ChartShimmer();

    final totalPaise =
        _segments.fold<int>(0, (a, b) => a + b.paise);
    final touchedSeg = widget.touchedIndex >= 0 &&
            widget.touchedIndex < _segments.length
        ? _segments[widget.touchedIndex]
        : null;

    return Column(
      children: [
        // ── Donut chart ────────────────────────────────────────────────────
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sections: _segments.asMap().entries.map((entry) {
                    final i = entry.key;
                    final seg = entry.value;
                    final isTouched = i == widget.touchedIndex;

                    return PieChartSectionData(
                      value: seg.paise.toDouble(),
                      color: seg.color,
                      radius: isTouched ? 54 : 46,
                      showTitle: false,
                      borderSide: isTouched
                          ? BorderSide(
                              color: seg.color.withValues(alpha: 0.6), width: 2)
                          : const BorderSide(color: Colors.transparent),
                    );
                  }).toList(),
                  centerSpaceRadius: 60,
                  sectionsSpace: 2,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      if (event is FlTapUpEvent) {
                        final idx = response
                            ?.touchedSection?.touchedSectionIndex;
                        widget.onTouch(idx ?? -1);
                      }
                    },
                  ),
                ),
              ),

              // Centre hole content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (touchedSeg != null) ...[
                    Text(
                      touchedSeg.name,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary).copyWith(
                        color: touchedSeg.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '₹${_fmt(touchedSeg.paise)}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      '${(touchedSeg.percentage * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary),
                    ),
                  ] else ...[
                    const Text('Total', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary)),
                    const SizedBox(height: 2),
                    Text(
                      '₹${_fmt(totalPaise)}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ── Legend ────────────────────────────────────────────────────────
        Wrap(
          spacing: 10,
          runSpacing: 6,
          children: _segments.asMap().entries.map((entry) {
            final i = entry.key;
            final seg = entry.value;
            final isTouched = i == widget.touchedIndex;

            return GestureDetector(
              onTap: () => widget.onTouch(isTouched ? -1 : i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isTouched
                      ? seg.color.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isTouched
                        ? seg.color.withValues(alpha: 0.4)
                        : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: seg.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${seg.name} · ₹${_fmt(seg.paise)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isTouched ? FontWeight.w600 : FontWeight.w400,
                        color: isTouched
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _fmt(int paise) {
    final r = paise / 100.0;
    if (r >= 100000) return '${(r / 100000).toStringAsFixed(1)}L';
    if (r >= 1000) return '${(r / 1000).toStringAsFixed(1)}K';
    return NumberFormat('#,##0', 'en_IN').format(r);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────────────────────

class _ChartSegment {
  final String name;
  final int paise;
  final Color color;
  final double percentage;

  const _ChartSegment({
    required this.name,
    required this.paise,
    required this.color,
    required this.percentage,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty + shimmer states
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyChart extends StatelessWidget {
  const _EmptyChart();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 160,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pie_chart_outline_rounded,
                size: 40, color: AppColors.textTertiary),
            SizedBox(height: 10),
            Text(
              'No expenses this month',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartShimmer extends StatelessWidget {
  const _ChartShimmer();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.primary,
        ),
      ),
    );
  }
}