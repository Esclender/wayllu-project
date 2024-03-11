import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_text.dart';
import 'package:wayllu_project/src/presentation/widgets/graphs_components/column_bar_chart.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class GraphicProductsScreen extends HookWidget {
  final int viewIndex;
  final double containersPadding = 20.0;

  GraphicProductsScreen({
    required this.viewIndex,
  });

  final List<ChartBarData> data = [
    ChartBarData('Ene', 120.00),
    ChartBarData('Feb', 150.00),
    ChartBarData('Mar', 300.00),
    ChartBarData('Abr', 60.40),
    ChartBarData('May', 140.00),
    ChartBarData('Jun', 140.00),
    ChartBarData('Jul', 140.00),
    ChartBarData('Ago', 145.00),
    ChartBarData('Sep', 145.00),
    ChartBarData('Oct', 148.00),
    ChartBarData('Nov', 147.00),
    ChartBarData('Dec', 125.00),
  ];

  final List<String> filters = [
    'Mes',
    'Año',
    'Categoria',
  ];

  void _onDropMenuChanged(_) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      body: Column(
        children: [
          TopVector(),
          _buildGraphicWithFilters(),
        ],
      ),
    );
  }

  Widget _buildGraphicWithFilters() {
    return Padding(
      padding: EdgeInsets.all(containersPadding),
      child: Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          GradientText(
            text: 'Registro de usuario',
            gradient: LinearGradient(
              colors: [mainColor, secondaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            fontSize: 25.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ColumnBarChartComponent(data: data),
          ),
          ...filters.map((String filterHint) {
            return _buildFilter(hint: filterHint);
          }),
        ],
      ),
    );
  }

  Widget _buildFilter({
    required String hint,
  }) {
    return SizedBox(
      width: 150.0,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        hint: Text(hint),
        items: const [
          DropdownMenuItem(
            child: Text('Item'),
            value: '1',
          ),
          DropdownMenuItem(
            child: Text('Item 2'),
            value: '2',
          ),
        ],
        onChanged: _onDropMenuChanged,
      ),
    );
  }
}
