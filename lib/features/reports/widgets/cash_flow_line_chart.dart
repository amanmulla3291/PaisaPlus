// lib/features/reports/widgets/cash_flow_line_chart.dart
// ─────────────────────────────────────────────────────────────────────────────
// Line chart showing Income vs Expense trends throughout the month.

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/isar/providers/reports_providers.dart';
import '../../../shared/theme/app_colors.dart';

class CashFlowLineChart extends ConsumerWidget {
  final DateTime month;

  const CashFlowLineChart({super.key, required this.month});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(cashFlowTrendProvider(month));

    return trendAsync.when(
      loading: () => Container(height: 300, color: AppColors.surface),
      error: (e, __) => const SizedBox.shrink(),
      data: (trend) {
        if (trend.isEmpty) return const SizedBox.shrink();

        return Container(
          height: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cash Flow Trend',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _LegendItem(color: AppColors.income, label: 'Income'),
                  const SizedBox(width: 16),
                  _LegendItem(color: AppColors.primary, label: 'Expense'),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: AppColors.divider.withValues(alpha: 0.1),
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 7, // Show every 7th day
                          getTitlesWidget: (val, meta) => Text(
                            val.toInt().toString(),
                            style: const TextStyle(fontSize: 10, color: AppColors.textTertiary),
                          ),
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      _buildLine(trend, isIncome: true),
                      _buildLine(trend, isIncome: false),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => AppColors.surfaceVariant,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            final amount = spot.y;
                            final formatter = NumberFormat('#,##,##0', 'en_IN');
                            return LineTooltipItem(
                              '₹${formatter.format(amount)}',
                              TextStyle(
                                color: spot.barIndex == 0 ? AppColors.income : AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  LineChartBarData _buildLine(Map<int, ({int income, int expense})> trend, {required bool isIncome}) {
    final spots = trend.entries.map((e) {
      final val = isIncome ? e.value.income : e.value.expense;
      return FlSpot(e.key.toDouble(), val / 100.0);
    }).toList();

    final color = isIncome ? AppColors.income : AppColors.primary;

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
