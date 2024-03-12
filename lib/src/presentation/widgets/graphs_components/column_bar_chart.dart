import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';

class ColumnBarChartComponent extends HookWidget {
  final List<ChartBarData> data;
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(
    enable: true,
    canShowMarker: false,
    format: 'point.x : S/ point.y',
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
        xValueMapper: (ChartBarData data, _) => data.x,
        yValueMapper: (ChartBarData data, _) => data.y,
        name: 'Gold',
        color: const Color.fromRGBO(8, 142, 255, 1),
      ),
    ];
  }
}
