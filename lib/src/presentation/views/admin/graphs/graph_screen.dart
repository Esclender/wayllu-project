import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';
import 'package:wayllu_project/src/presentation/cubit/ventas_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
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
  ];

  final List<String> filters = [
    'Año',
    'Mes',
  ];

  void _onDropMenuChanged(
      String? selectedValue, BuildContext context, String filterType) {
    final ventasListCubit = context.read<VentasListCubit>();

    if (filterType == 'Año') {
      // Si se seleccionó el filtro de año, llama a la función para filtrar por año
      ventasListCubit.getVentasByYearAndMonth(selectedValue ?? '', '');
    } else if (filterType == 'Mes') {
      // Si se seleccionó el filtro de mes, también necesitas el año actual para la llamada
      final currentYear = DateTime.now().year;
      ventasListCubit.getVentasByYearAndMonth(
          '$currentYear/$selectedValue', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ventasListCubit = context.watch<VentasListCubit>();
    final dataVentas = useState<List<VentasList>>([]);

    useEffect(
      () {
        ventasListCubit.getVentas();
        final subscription = ventasListCubit.stream.listen((ventas) {
          if (ventas != null) {
            dataVentas.value = ventas;
          }
        });

        return subscription.cancel;
      },
      [ventasListCubit],
    );

    final List<CardTemplate> cardData = dataVentas.value.map((venta) {
      return CardTemplate(
        codigoArtesano: 0001,
        nombre: '${venta.COD_PRODUCTO}' ?? '',
        url: venta.IMAGEN ?? 'https://via.placeholder.com/150',
        descriptions: [
          DescriptionItem(
              field: 'Fecha de Registro', value: venta.FECHA_REGISTRO ?? ''),
          DescriptionItem(field: 'Cantidad', value: '${venta.CANTIDAD}' ?? ''),
          DescriptionItem(
              field: 'Descripción', value: '${venta.DESCRIPCION}' ?? ''),
        ],
      );
    }).toList();

    return Scaffold(
      backgroundColor: bgPrimary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                TopVector(),
                _buildGraphicWithFilters(context),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: GradientText(
                    text: 'Todas las ventas',
                    fontSize: 18.0,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 1.4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: cardData.length,
                    itemBuilder: (context, index) {
                      return _buildItemContainer(itemData: cardData[index]);
                    },
                  ),
                ),
              ],
            ),
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
            border:
                Border.all(width: 0.5, color: Colors.white.withOpacity(0.5)),
            shadowStrength: 5,
            borderRadius: BorderRadius.circular(5),
            shadowColor: Colors.white.withOpacity(0.24),
            child: ColumnBarChartComponent(data: data),
          ),
          ...filters.map((String filterHint) {
            return _buildFilter(context, hint: filterHint);
          }),
        ],
      ),
    );
  }

  Widget _buildFilter(BuildContext context, {required String hint}) {
    final currentYear = DateTime.now().year;

    // Crear una lista de DropdownMenuItem para los años desde 2023 hasta el año actual
    final List<DropdownMenuItem<String>> yearItems = [];
    for (int year = 2023; year <= currentYear; year++) {
      yearItems.add(DropdownMenuItem(
          value: year.toString(), child: Text(year.toString())));
    }
    final List<DropdownMenuItem<String>> monthItems = [
      const DropdownMenuItem(value: '1', child: Text('Enero')),
      const DropdownMenuItem(value: '2', child: Text('Febrero')),
      const DropdownMenuItem(value: '3', child: Text('Marzo')),
      const DropdownMenuItem(value: '4', child: Text('Abril')),
      const DropdownMenuItem(value: '5', child: Text('Mayo')),
      const DropdownMenuItem(value: '6', child: Text('Junio')),
      const DropdownMenuItem(value: '7', child: Text('Julio')),
      const DropdownMenuItem(value: '8', child: Text('Agosto')),
      const DropdownMenuItem(value: '9', child: Text('Septiembre')),
      const DropdownMenuItem(value: '10', child: Text('Octubre')),
      const DropdownMenuItem(value: '11', child: Text('Noviembre')),
      const DropdownMenuItem(value: '12', child: Text('Diciembre')),
    ];
    List<DropdownMenuItem<String>> items = [];
    if (hint == 'Año') {
      items = yearItems;
    } else {
      items = monthItems;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.43,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        hint: Text(
          hint,
          style: const TextStyle(fontSize: 12),
        ),
        items: items,
        onChanged: (value) => _onDropMenuChanged(value, context, hint),
      ),
    );
  }

  Widget _listTile({
    required Widget leading,
    required Widget title,
    required List<DescriptionItem> fields,
  }) {
    return Row(
      children: [
        leading,
        const Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            ...fields.map(
              (f) => Text(
                '${f.field}: ${f.value}',
                style: TextStyle(
                  color: smallWordsColor.withOpacity(0.7),
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemContainer({required CardTemplate itemData}) {
    final BoxDecoration decoration = BoxDecoration(
      color: bgPrimary,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12, // Cambia esto por tu sombra simpleShadow
          blurRadius: 4.0,
          spreadRadius: 2.0,
        ),
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    );

    return Stack(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              decoration: decoration,
              child: _listTile(
                leading: _buildImageAvatar(itemData.url),
                title: Text(itemData.nombre),
                fields: itemData.descriptions,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: _itemMarker(secondary),
            )
            // Cambia esto por tu color secondary
          ],
        ),
      ],
    );
  }

  Widget _buildImageAvatar(String url) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _itemMarker(Color colorMarker) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 5.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: colorMarker,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
    );
  }
}
