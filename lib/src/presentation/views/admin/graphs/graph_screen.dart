import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wayllu_project/src/domain/models/graphs/chart_column_bar.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/list_products_model.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';
import 'package:wayllu_project/src/presentation/cubit/ventas_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/expand_tile.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/graphs_components/column_bar_chart.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:collection/collection.dart';

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
        '${selectedValues['Año'] ?? currentYear}/$selectedValue',
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
    final isLoading = useState<bool>(true);

    useEffect(
      () {
        final currentYear = DateTime.now().year;

        ventasListCubit.getVentasByYearAndMonth('$currentYear', '');
        final subscription = ventasListCubit.stream.listen((ventas) {
          if (ventas != null) {
            dataVentas.value = ventas;
          }
          isLoading.value = false;
        });
        initializeDateFormatting('es_ES');
        return subscription.cancel;
      },
      [ventasListCubit],
    );

    List<ChartBarData> chartData = [];

    if (selectedFilter.value.startsWith('Mes')) {
      final Map<DateTime, double> dailySums = {};
      DateTime? latestDate;

      for (final venta in dataVentas.value) {
        final date = DateTime.parse(venta.FECHA_REGISTRO);

        if (date.month.toString() == selectedValues.value['Mes']) {
          dailySums[date] = (dailySums[date] ?? 0) + (venta.CANTIDAD ?? 0);

          if (latestDate == null || date.isAfter(latestDate)) {
            latestDate = date;
          }
        }
      }

      if (latestDate != null) {
        for (int i = 0; i < 5; i++) {
          final date = latestDate.subtract(Duration(days: i));
          final formattedDate = DateFormat('dd/MM').format(date);
          final sales = dailySums[date] ?? 0;
          chartData.add(ChartBarData(formattedDate, sales, date.day));
        }
      }

      chartData = chartData.reversed
          .toList(); // Aseguramos que estén en orden de fecha ascendente
    } else {
      final Map<int, double> monthlySums = {};
      for (final venta in dataVentas.value) {
        final month = DateTime.parse(venta.FECHA_REGISTRO).month;
        monthlySums[month] = (monthlySums[month] ?? 0) + (venta.CANTIDAD ?? 0);
      }

      chartData = monthlySums.entries
          .map((entry) => ChartBarData(
                DateFormat.MMMM('es_ES').format(DateTime(1, entry.key)),
                entry.value,
                entry.key,
              ))
          .toList();
    }

    chartData.sort((a, b) => a.monthNumber.compareTo(b.monthNumber));

    final groupedVentas = groupBy<VentasList, String>(
      dataVentas.value,
      (venta) => '${venta.COD_PRODUCTO}',
    );

    final List<CardTemplateProducts> cardData =
        groupedVentas.entries.map((entry) {
      final codigoProducto = entry.key;
      final ventas = entry.value;
      final totalCantidad = ventas.fold<int>(
        0,
        (sum, venta) => sum + (venta.CANTIDAD ?? 0),
      );
      final producto = ventas.first;

      return CardTemplateProducts(
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
        final year = selectedFilter.value.split('/')[1];
        return 'Ventas del Año $year';
      } else if (selectedFilter.value.startsWith('Mes')) {
        final month = selectedFilter.value.split('/')[1];
        final year =
            selectedValues.value['Año'] ?? DateTime.now().year.toString();
        return 'Ventas de $month/$year';
      } else {
        return 'Ventas Filtradas';
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
                Column(
                  children: [
                    _buildGraphicWithFilters(
                      context,
                      selectedFilter,
                      selectedValues.value,
                      chartData,
                    ),
                  ],
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
                      border: Border.all(color: bottomNavBarStroke, width: 0.5),
                    ),
                    child: GestureDetector(
                      onTap: () => _clearFilters(
                        context,
                        selectedFilter,
                        selectedValues.value,
                      ),
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
                if (isLoading.value)
                  ListView.separated(
                    separatorBuilder: (context, index) => const Gap(8),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext c, int ind) {
                      return _buildShimmerItemContainer(context);
                    },
                  )
                else if (dataVentas.value.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/nodatafound.png'),
                        const Text('No hay resultados'),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
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
    List<ChartBarData> data,
  ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(containersPadding),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              GradientText(
                text: 'Registro de ventas',
                fontSize: 25.0,
              ),
              Container(
                height: 200,
                child: ColumnBarChartComponent(
                  data: data,
                ),
              ),
              ...filters.map((String filterHint) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildFilter(
                    context,
                    hint: filterHint,
                    selectedFilter: selectedFilter,
                    selectedValues: selectedValues,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilter(BuildContext context,
      {required String hint,
      required ValueNotifier<String> selectedFilter,
      required Map<String, String> selectedValues}) {
    final currentYear = DateTime.now().year;
    final List<DropdownMenuItem<String>> yearItems = [];

    for (int year = 2023; year <= currentYear; year++) {
      yearItems.add(
        DropdownMenuItem(
          value: year.toString(),
          child: Text(year.toString()),
        ),
      );
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

    return DropdownButton<String>(
      value: selectedValues[hint],
      hint: Text(hint),
      items: items,
      padding: EdgeInsets.only(right: 6),
      onChanged: (String? newValue) {
        _onDropMenuChanged(
          newValue,
          context,
          hint,
          selectedFilter,
          selectedValues,
        );
      },
    );
  }

  Widget _buildShimmerItemContainer(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
      color: bottomNavBar,
      boxShadow: [
        simpleShadow,
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    );

    final double additionalPadding = 10;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: decoration,
                child: _buildShimmerEffect(context),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 5 + additionalPadding),
                decoration: decoration,
                child: _buildShimmerEffect2(context),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 95,
                  top: 5 + additionalPadding,
                ),
                decoration: decoration,
                child: _buildShimmerEffectText(context),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 95,
                  top: 20 + additionalPadding,
                ),
                decoration: decoration,
                child: _buildShimmerEffectText(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect2(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
        width: 55,
        height: 55,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffectText(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
        width: 100,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
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

Widget _buildItemContainer({
  required String productCode,
  required List<VentasList> ventas,
}) {
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
    border: Border.all(color: Colors.transparent),
  );

  final totalQuantity =
      ventas.fold<int>(0, (sum, item) => sum + (item.CANTIDAD ?? 0));
  final String imageUrl = ventas.isNotEmpty && ventas.first.IMAGEN != null
      ? ventas.first.IMAGEN!
      : 'https://via.placeholder.com/150'; // URL de la imagen por defecto

  return ExpansionTileImp(
    title: Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      //padding: const EdgeInsets.only(bottom: 5),
      decoration: decoration,

      child: ListTile(
        leading: _buildImageAvatar(imageUrl),
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
                color: secondary,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                'Total vendidos: $totalQuantity',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: bgPrimary,
                ),
              ),
            ),
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
                Text('Cantidad: ${venta.CANTIDAD}', style: infoCardsProducts()),
                Text(
                  'Descripción: ${venta.DESCRIPCION}',
                  style: infoCardsProducts(),
                ),
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
