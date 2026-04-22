// lib/features/home/widgets/spend_line_chart.dart
//
// PaisaPlus – Daily Spend Line Chart (fl_chart)
// -----------------------------------------------
// Shows daily expense totals for the selected month as a smooth line chart.
// X-axis: days 1–N. Y-axis: amount in INR (formatted as K/L).
// A gradient fill under the line adds visual depth.
// Touch: shows a tooltip with the exact date + amount.
//
// Data: dailyExpenseTotalsProvider(month) → Map<DateTime, int paise>

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/service_providers.dart';
import '../../../shared/theme/app_colors.dart';

class SpendLineChart extends ConsumerWidget {
  final DateTime selectedMonth;

  const SpendLineChart({super.key, required this.selectedMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyAsync = ref.watch(dailyExpenseTotalsProvider(selectedMonth));

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: dailyAsync.when(
        loading: () => const SizedBox(
          height: 140,
          child: Center(
            child: CircularProgressIndicator(
                strokeWidth: 2, color: AppColors.primary),
          ),
        ),
        error: (_, __) => const SizedBox(height: 140),
        data: (dailyTotals) {
          if (dailyTotals.isEmpty) {
            return const SizedBox(
              height: 140,
              child: Center(
                child: Text(
                  'No data yet',
                  style: TextStyle(
                      fontSize: 13, color: AppColors.textTertiary),
                ),
              ),
            );
          }

          return _LineChartContent(
            dailyTotals: dailyTotals,
            selectedMonth: selectedMonth,
          );
        },
      ),
    );
  }
}

class _LineChartContent extends StatefulWidget {
  final Map<DateTime, int> dailyTotals;
  final DateTime selectedMonth;

  const _LineChartContent({
    required this.dailyTotals,
    required this.selectedMonth,
  });

  @override
  State<_LineChartContent> createState() => _LineChartContentState();
}

class _LineChartContentState extends State<_LineChartContent> {
  int _touchedSpotIndex = -1;

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
        widget.selectedMonth.year, widget.selectedMonth.month);

    // Build spots — one per day (0 if no spend that day)
    final spots = <FlSpot>[];
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(
          widget.selectedMonth.year, widget.selectedMonth.month, day);
      final paise = widget.dailyTotals[date] ?? 0;
      spots.add(FlSpot(day.toDouble(), paise / 100.0));
    }

    final maxY =
        spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.2;
    final effectiveMaxY = maxY < 100 ? 100.0 : maxY;

    return SizedBox(
      height: 150,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: daysInMonth.toDouble(),
          minY: 0,
          maxY: effectiveMaxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: effectiveMaxY / 4,
            getDrawingHorizontalLine: (_) => const FlLine(
              color: AppColors.border,
              strokeWidth: 0.5,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 44,
                interval: effectiveMaxY / 4,
                getTitlesWidget: (value, _) {
                  return Text(
                    _fmtY(value),
                    style: const TextStyle(
                        fontSize: 9, color: AppColors.textTertiary),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: daysInMonth <= 15 ? 2 : 5,
                getTitlesWidget: (value, _) {
                  if (value % (daysInMonth <= 15 ? 2 : 5) != 0) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                        fontSize: 9, color: AppColors.textTertiary),
                  );
                },
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineTouchData: LineTouchData(
            touchCallback: (event, response) {
              if (event is FlTapUpEvent || event is FlPanEndEvent) {
                setState(() {
                  final spotIndex = response
                      ?.lineBarSpots?.first.x.toInt();
                  _touchedSpotIndex = spotIndex ?? -1;
                });
              }
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => AppColors.surfaceVariant,
              tooltipRoundedRadius: 8,
              getTooltipItems: (spots) => spots.map((spot) {
                return LineTooltipItem(
                  'Day ${spot.x.toInt()}\n₹${_fmtTooltip(spot.y)}',
                  const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: AppColors.primary,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                // In fl_chart 0.69.x FlSpot has no spotIndex — compare by x value
                checkToShowDot: (spot, _) =>
                    spot.x.toInt() == _touchedSpotIndex,
                getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.primary,
                  strokeWidth: 2,
                  strokeColor: AppColors.background,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.20),
                    AppColors.primary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      ),
    );
  }

  String _fmtY(double value) {
    if (value >= 100000) return '${(value / 100000).toStringAsFixed(0)}L';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toInt().toString();
  }

  String _fmtTooltip(double value) {
    return NumberFormat('#,##,##0', 'en_IN').format(value);
  }
}