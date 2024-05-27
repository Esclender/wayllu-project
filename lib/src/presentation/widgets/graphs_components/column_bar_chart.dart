import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class ColumnBarChartComponent extends HookWidget {
  final List<ChartBarData> data;
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(
    enable: true,
    canShowMarker: false,
    format: 'point.y productos vendidos',
    header: '',
  );

  ColumnBarChartComponent({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0.0,
      primaryXAxis: const CategoryAxis(
        majorTickLines: MajorTickLines(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: TextStyle(color: Color(0xffFCF6F0)),
      ),
      primaryYAxis: const NumericAxis(
        isVisible: false,
      ),
      series: _getColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<CartesianSeries<ChartBarData, String>> _getColumnSeries() {
    return <CartesianSeries<ChartBarData, String>>[
      ColumnSeries<ChartBarData, String>(
        trackBorderWidth: 0.0,
        dataSource: data,
        xValueMapper: (ChartBarData data, _) => data.label,
        yValueMapper: (ChartBarData data, _) => data.value,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        name: 'Gold',
        color: secondaryColor,
        opacity: 1,
      ),
    ];
  }
}
