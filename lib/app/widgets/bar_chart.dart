import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartColumnData {
  ChartColumnData(this.x, this.y, this.y1);
  final String x;
  final double? y;
  final double? y1;
}

class BarChart extends StatefulWidget {
  const BarChart({
    super.key,
    required this.countText,
    required this.incrementText,
    required this.chartData,
    required this.title,
    required this.description,
  });

  final String countText;
  final String incrementText;
  final List<ChartColumnData> chartData;
  final String title;
  final String description;

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightPrimary,
      surfaceTintColor: AppColors.lightPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.countText,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black),
                ),
                SizedBox(width: 10),
                const Icon(Icons.arrow_upward, color: AppColors.primary),
                Text(widget.incrementText,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary)),
                Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    size: 40,
                  ),
                )
              ],
            ),
            SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 10),
              borderColor: Colors.transparent,
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              enableSideBySideSeriesPlacement: false,
              primaryXAxis: CategoryAxis(
                isVisible: false,
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
                minimum: 0,
                maximum: 2,
                interval: 0.5,
              ),
              series: <CartesianSeries>[
                ColumnSeries<ChartColumnData, String>(
                  borderRadius: BorderRadius.circular(20),
                  dataSource: widget.chartData,
                  width: 0.5,
                  color: Color(0xFFE9EDF7),
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y,
                ),
                ColumnSeries<ChartColumnData, String>(
                  borderRadius: BorderRadius.circular(20),
                  dataSource: widget.chartData,
                  width: 0.5,
                  color: AppColors.primary,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y1,
                ),
              ],
            ),
            Text(widget.title,
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700)),
            Text(widget.description,
                style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
