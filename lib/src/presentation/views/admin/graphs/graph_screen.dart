import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';
import 'package:wayllu_project/src/presentation/cubit/ventas_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/graphs_components/column_bar_chart.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:collection/collection.dart';
import 'package:wayllu_project/src/utils/extensions/scroll_controller_extension.dart';

@RoutePage()
class GraphicProductsScreen extends HookWidget {
  final int viewIndex;
  final double containersPadding = 20.0;

  GraphicProductsScreen({
    required this.viewIndex,
  });

  final List<String> filters = [
    'Año',
    'Mes',
  ];

  void _onDropMenuChanged(
    String? selectedValue,
    BuildContext context,
    String filterType,
    ValueNotifier<String> selectedFilter,
    Map<String, String> selectedValues,
  ) {
    final ventasListCubit = context.read<VentasListCubit>();

    if (filterType == 'Año') {
      ventasListCubit.getVentasByYearAndMonth(selectedValue ?? '', '');
      selectedFilter.value = 'Año/$selectedValue';
      selectedValues['Año'] = selectedValue ?? '';
    } else if (filterType == 'Mes') {
      final currentYear = DateTime.now().year;
      ventasListCubit.getVentasByYearAndMonth(
        '$currentYear/$selectedValue',
        '',
      );
      selectedFilter.value = 'Mes/$selectedValue';
      selectedValues['Mes'] = selectedValue ?? '';
    }
  }

  void _clearFilters(
    BuildContext context,
    ValueNotifier<String> selectedFilter,
    Map<String, String> selectedValues,
  ) {
    final ventasListCubit = context.read<VentasListCubit>();
    ventasListCubit.getVentas();
    selectedFilter.value = '';
    selectedValues.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ventasListCubit = context.watch<VentasListCubit>();
    final dataVentas = useState<List<VentasList>>([]);
    final selectedFilter = useState<String>('');
    final selectedValues = useState<Map<String, String>>({});
    final scrollController = useScrollController();

    useEffect(
      () {
        final currentYear = DateTime.now().year;

        ventasListCubit.getVentasByYearAndMonth('$currentYear', '');

        final subscription = ventasListCubit.stream.listen((ventas) {
          if (ventas != null) {
            dataVentas.value = ventas;
          }
        });

        initializeDateFormatting('es_ES');
        return subscription.cancel;
      },
      [ventasListCubit],
    );

    List<ChartBarData> chartData;

    if (selectedFilter.value.startsWith('Mes')) {
      // Crear datos agrupados por día

      final Map<int, double> dailySums = {};
      for (final venta in dataVentas.value) {
        final date = DateTime.parse(venta.FECHA_REGISTRO);

        if (date.month.toString() == selectedValues.value['Mes']) {
          final dayOfWeek = date.weekday;
          dailySums[dayOfWeek] =
              (dailySums[dayOfWeek] ?? 0) + (venta.CANTIDAD ?? 0);
        }
      }

      chartData = dailySums.entries
          .map((entry) => ChartBarData(
                DateFormat.EEEE('es_ES').format(DateTime(1, entry.key)),
                entry.value,
                entry.key,
              ))
          .toList();
    } else {
      // Crear datos agrupados por mes
      final Map<int, double> monthlySums = {};
      for (final venta in dataVentas.value) {
        final month = DateTime.parse(venta.FECHA_REGISTRO).month;
        monthlySums[month] = (monthlySums[month] ?? 0) + (venta.CANTIDAD ?? 0);
      }

      chartData = monthlySums.entries
          .map((entry) => ChartBarData(
                DateFormat.MMMM('es_ES').format(DateTime(0, entry.key)),
                entry.value,
                entry.key,
              ))
          .toList();
    }

    chartData.sort((a, b) => a.monthNumber.compareTo(b.monthNumber));

    final groupedVentas = groupBy<VentasList, String>(
      dataVentas.value,
      (venta) => '${venta.COD_PRODUCTO}' ?? '',
    );

    final List<CardTemplate> cardData = groupedVentas.entries.map((entry) {
      final codigoProducto = entry.key;
      final ventas = entry.value;
      final totalCantidad = ventas.fold<int>(
        0,
        (sum, venta) => sum + (venta.CANTIDAD ?? 0),
      );
      final producto = ventas.first;

      return CardTemplate(
        nombre: codigoProducto,
        url: producto.IMAGEN ?? 'https://via.placeholder.com/150',
        descriptions: [
          DescriptionItem(field: 'Total Vendido', value: '$totalCantidad'),
          DescriptionItem(
            field: 'Descripción',
            value: producto.DESCRIPCION ?? '',
          ),
        ],
      );
    }).toList();

    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildGroupedItemContainer(
      BuildContext context,
      String productCode,
      List<VentasList> ventas,
    ) {
      return _buildItemContainer(
        productCode: productCode,
        ventas: ventas,
      );
    }

    String getTitle() {
      if (selectedFilter.value.isEmpty) {
        return 'Todas las ventas';
      } else if (selectedFilter.value.startsWith('Año')) {
        return 'Ventas Anuales';
      } else {
        final parts = selectedFilter.value.split('/');
        final month = parts[1];
        final year = DateTime.now().year;
        return 'Ventas de 0$month/$year';
      }
    }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopVector(),
                _buildGraphicWithFilters(
                  context,
                  selectedFilter,
                  selectedValues.value,
                  chartData,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    getTitle(),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                if (selectedFilter.value.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(left: 16, bottom: 6, top: 2),
                    width: MediaQuery.of(context).size.width * 0.32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: iconColor.withOpacity(0.5),
                        border:
                            Border.all(color: bottomNavBarStroke, width: 0.5)),
                    child: GestureDetector(
                      onTap: () => _clearFilters(
                          context, selectedFilter, selectedValues.value),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              color: bottomNavBar,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Quitar filtro',
                              style: TextStyle(
                                color: bottomNavBar,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 1.4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: cardData.length,
                    itemBuilder: (context, index) {
                      final key = groupedVentas.keys.elementAt(index);
                      return _buildGroupedItemContainer(
                        context,
                        key,
                        groupedVentas[key]!,
                      );
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

  Widget _buildGraphicWithFilters(
      BuildContext context,
      ValueNotifier<String> selectedFilter,
      Map<String, String> selectedValues,
      List<ChartBarData> data) {
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
            child: ColumnBarChartComponent(
              data: data,
            ),
          ),
          ...filters.map((String filterHint) {
            return _buildFilter(
              context,
              hint: filterHint,
              selectedFilter: selectedFilter,
              selectedValues: selectedValues,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilter(BuildContext context,
      {required String hint,
      required ValueNotifier<String> selectedFilter,
      required Map<String, String> selectedValues}) {
    final currentYear = DateTime.now().year;
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
        value: selectedValues[hint], // Valor seleccionado
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        hint: Text(
          hint,
          style: const TextStyle(fontSize: 12),
        ),
        items: items,
        onChanged: (value) => _onDropMenuChanged(
            value, context, hint, selectedFilter, selectedValues),
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

  Widget _buildItemContainer(
      {required String productCode, required List<VentasList> ventas}) {
    final BoxDecoration decoration = BoxDecoration(
      color: bottomNavBar,
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 95, 95, 95).withOpacity(0.08),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(
            0,
            1,
          ),
        ),
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    );

    final totalQuantity =
        ventas.fold<int>(0, (sum, item) => sum + (item.CANTIDAD ?? 0));
    final String imageUrl = ventas.isNotEmpty && ventas.first.IMAGEN != null
        ? ventas.first.IMAGEN!
        : 'https://via.placeholder.com/150'; // URL de la imagen por defecto

    return ExpansionTile(
      title: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        //padding: const EdgeInsets.only(bottom: 5),
        decoration: decoration,

        child: ListTile(
          leading: _buildImageAvatar(imageUrl), // Icono para el producto
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productCode,
                style: const TextStyle(fontSize: 18),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: secondary, borderRadius: BorderRadius.circular(3)),
                  child: Text(
                    'Total vendidos: $totalQuantity',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: bgPrimary),
                  )),
            ],
          ),
        ),
      ),
      children: ventas.map((venta) {
        return Column(
          children: [
            ListTile(
              title: Text(
                'Fecha de Registro: ${venta.formattingDate()}',
                style: infoCardsProducts(),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cantidad: ${venta.CANTIDAD}',
                      style: infoCardsProducts()),
                  Text('Descripción: ${venta.DESCRIPCION}',
                      style: infoCardsProducts()),
                ],
              ),
            ),
            Divider(),
          ],
        );
      }).toList(),
    );
  }

  TextStyle infoCardsProducts() => TextStyle(fontSize: 12);

  Widget _buildImageAvatar(String url) {
    return Container(
      width: 60,
      height: 60,
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
