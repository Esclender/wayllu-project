import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';
import 'package:wayllu_project/src/domain/models/venta/venta_repo.dart';
import 'package:wayllu_project/src/presentation/cubit/ventas_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/graphs_components/column_bar_chart.dart';
import 'package:wayllu_project/src/presentation/widgets/list_ventas.dart';
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

  ];

  final List<String> filters = [
    'Mes',
    'Año',
    'Categoria',
  ];

  void _onDropMenuChanged(_) {}

  @override
  Widget build(BuildContext context) {
    final ventasListCubit = context.watch<VentasListCubit>();
    List<VentasList> data = [];

    print(ventasListCubit);
    useEffect(
      () {
        ventasListCubit.getVentas();

        ventasListCubit.stream.listen((ventas) {
          if (ventas != null) {
            data = ventas;
            // Imprime los datos recibidos
            data.forEach((venta) {
              print('Fecha de Registro: ${venta.FECHA_REGISTRO}');
              print('Cantidad: ${venta.CANTIDAD}');
              print('Descripción: ${venta.DESCRIPCION}');
              print('Código de Producto: ${venta.COD_PRODUCTO}');
              print('ID de Registro de Ventas: ${venta.registrosVentasId}');
              print('Imagen: ${venta.IMAGEN}');
              print('');
            });
          }
        });
      },
      [],
    );
    return Scaffold(
      backgroundColor: bgPrimary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(children: [
              TopVector(),
              _buildGraphicWithFilters(context),
              SizedBox(
                  height: 800,
                  width: MediaQuery.of(context).size.width,
                  child: VentasCardsItemsList(listType: ListEnums.ventas,
                  contextF: context,
                  dataToRender: data,
                  ))
             
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
