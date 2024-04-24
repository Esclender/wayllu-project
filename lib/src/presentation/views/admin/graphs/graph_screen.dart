import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/graphs_components/column_bar_chart.dart';
import 'package:wayllu_project/src/presentation/widgets/list_generator.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class GraphicProductsScreen extends HookWidget {
  final int viewIndex;
  final double containersPadding = 20.0;

  GraphicProductsScreen({
    required this.viewIndex,
  });

  final List<CardTemplate> dataToRender = [
    CardTemplate(
      url:
          'https://images.unsplash.com/profile-1446404465118-3a53b909cc82?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=3ef46b07bb19f68322d027cb8f9ac99f',
      nombre: 'Sombreros',
      descriptions: [
        DescriptionItem(field: 'Ventas totales', value: '145'),
        DescriptionItem(field: 'Ingresos totales', value: 'S/ 40.000'),
      ],
    ),
  ];

  final List<ChartBarData> data = [
    ChartBarData('Ene', 120.00),
    ChartBarData('Feb', 150.00),
    ChartBarData('Mar', 300.00),
    ChartBarData('Abr', 60.40),
    ChartBarData('May', 140.00),
    ChartBarData('Jun', 140.00),
    ChartBarData('Jul', 140.00),

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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              TopVector(),
              _buildGraphicWithFilters(context),
              _buildMohtlyProductsList(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildGraphicWithFilters(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(containersPadding),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          GradientText(
            text: 'Registro de ventas',
            fontSize: 25.0,
          ),
          GlassContainer(
            height: 200,
            blur: 4,
            color: Colors.white.withOpacity(0.8),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 102, 102, 102),
                Color.fromARGB(255, 59, 60, 61),
              ],
            ),
            //--code to remove border
            border: Border.all(width: 0.5, color: Colors.white.withOpacity(0.5)),
            shadowStrength: 5,
            borderRadius: BorderRadius.circular(5),
            shadowColor: Colors.white.withOpacity(0.24),
            child:ColumnBarChartComponent(data: data),
          ),
    
          ...filters.map((String filterHint) {
            return _buildFilter(context, hint: filterHint);
          }),
        ],
      ),
    );
  }

  Widget _buildFilter(BuildContext context,{
    required String hint,
  }) {
    return SizedBox(
      width:MediaQuery.of(context).size.width*0.28,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        hint: Text(hint, style: TextStyle(fontSize: 12),),
        items: const [
          DropdownMenuItem(
            value: '1',
            child: Text('Item'),
          ),
          DropdownMenuItem(
            value: '2',
            child: Text('Item 2'),
          ),
        ],
        onChanged: _onDropMenuChanged,
      ),
    );
  }

  Widget _buildMohtlyProductsList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: containersPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMohtlyProductsListTitle(title: 'Enero'),
          CardTemplateItemsList(
            listType: ListEnums.products,
            dataToRender: dataToRender,
            isScrollable: false,
          ),
        ],
      ),
    );
  }

  Widget _buildMohtlyProductsListTitle({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          text: title,
          fontSize: 25.0,
        ),
        GradientDecoration(
          width: 40.0,
        ),
      ],
    );
  }
}
