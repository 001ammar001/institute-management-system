import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_system/core/functions/linear_scalr.dart';
import 'package:institute_management_system/features/dashbord/presentation/widgets/custom_bar_card.dart';

class LineChartCard extends StatelessWidget {
  final ScaleLinear scaleLinear;
  final Map<int, String> leftTitle;
  final Map<int, String> bottomTitle;
  final List<FlSpot> spots;

  const LineChartCard({
    super.key,
    required this.leftTitle,
    required this.bottomTitle,
    required this.spots,
    required this.scaleLinear,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Steps Overview",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          //TODO: if we want to add a respnosive change the condition
          Expanded(
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        return LineTooltipItem(
                          '${scaleLinear.invert(barSpot.y)}',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return bottomTitle[value.toInt()] != null
                            ? SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 10,
                                child: Text(
                                  bottomTitle[value.toInt()].toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return leftTitle[value.toInt()] != null
                            ? Text(
                                leftTitle[value.toInt()].toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const SizedBox();
                      },
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    curveSmoothness: 0,
                    // color: Theme.of(context).primaryColor,
                    color: Colors.yellow,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          // Theme.of(context).primaryColor.withOpacity(0.5),
                          Colors.yellow,
                          Colors.transparent
                        ],
                      ),
                      show: true,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    dotData: const FlDotData(show: true),
                    spots: spots,
                  )
                ],
                minX: 0,
                maxX: 112,
                maxY: 100,
                minY: -5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
