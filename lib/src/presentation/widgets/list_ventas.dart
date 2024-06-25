import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class VentasCardsItemsList extends HookWidget {
  final BuildContext contextF;
  final ListEnums listType;
  final List<VentasList> dataToRender;
  final String query;
  final ScrollController? scrollController;
  final String? categoriaSeleccionada;

  final appRouter = getItAppRouter<AppRouter>();

  VentasCardsItemsList({
    required this.contextF,
    required this.listType,
    required this.dataToRender,
    this.query = '',
    this.categoriaSeleccionada,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final ventasFiltrados = dataToRender;

    return _buildScrollableList(
      ventasFiltrados,
    );
  }

  Widget _buildScrollableList(
    List<VentasList> ventasFiltrados,
  ) {
    return ListView.builder(
      //separatorBuilder: (context, index) => const SizedBox(height: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ventasFiltrados.length,
      itemBuilder: (BuildContext c, int ind) {
        return Row(
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: ind == (ventasFiltrados.length / 2).ceil() - 1
                    ? ventasFiltrados.length % 2
                    : 2,
                itemBuilder: (BuildContext context, int index) {
                  final dataIndex = ind * 2 + index;
                  if (dataIndex < ventasFiltrados.length) {
                    final producto = ventasFiltrados[dataIndex];
                    return _buildItemContainer(
                      context,
                      itemData: producto,
                    );
                  } else {
                    return const SizedBox(); // No hay más datos para mostrar
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItemContainer(
    BuildContext context, {
    required VentasList itemData,
  }) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.43,
              height: MediaQuery.of(context).size.width * 0.44,
              decoration: BoxDecoration(
                color: bottomNavBar,
                boxShadow: [
                  simpleShadow,
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: _buildListTile(context, itemData),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(
                        color: iconColor.withOpacity(0.6),
                        width: 0.5,
                      ),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    bottomNavBar.withOpacity(0.4),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.abc),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context,
    VentasList itemData,
  ) {
    final BoxDecoration decoration = BoxDecoration(
      color: bottomNavBar,
      boxShadow: [
        simpleShadow,
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      height: MediaQuery.of(context).size.width * 0.44,
      decoration: decoration,
      child: _listTile(
        context: context,
        leading: _buildImageProduct(context, itemData.IMAGEN!),
        title: Text(itemData.COD_PRODUCTO.toString()),
        //fields: itemData.descriptionsFields,
      ),
    );
  }

  Widget _buildImageProduct(BuildContext context, String url) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.26,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _listTile({
    required BuildContext context,
    required Widget leading,
    required Widget title,
    // required List<DescriptionItem> fields,
  }) {
    return Column(
      children: [
        leading,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  title,
                  /* ...fields.map(
                    (f) => Text(
                      f.value,
                      style: TextStyle(
                        color: smallWordsColor.withOpacity(0.7),
                        fontSize: 8,
                      ),
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildEditButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.translucent,
        child: const Text(
          'Editar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
