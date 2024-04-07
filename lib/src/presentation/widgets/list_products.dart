import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/enums/user_roles.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class ProductsCardsItemsList extends HookWidget {
  final ListEnums listType;
  final List<Producto> dataToRender;
  final String query;
  final bool isScrollable;
  final String?
      categoriaSeleccionada; // Nuevo parámetro para la categoría seleccionada

  // Dependencies Injection
  final appRouter = getIt<AppRouter>();

  ProductsCardsItemsList({
    required this.listType,
    required this.dataToRender,
    this.isScrollable = true,
    this.query = '',
    this.categoriaSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    final productosFiltrados = categoriaSeleccionada != null
      ? dataToRender
          .where((producto) => producto.category == categoriaSeleccionada)
          .toList()
      : dataToRender;

    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 8),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: productosFiltrados.length,
      itemBuilder: (BuildContext c, int ind) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                physics:
                    isScrollable ? null : const NeverScrollableScrollPhysics(),
                itemCount: ind == (productosFiltrados.length / 2).ceil() - 1
                    ? productosFiltrados.length % 2
                    : 2,
                itemBuilder: (BuildContext context, int index) {
                  final dataIndex = ind * 2 + index;
                  if (dataIndex < productosFiltrados.length) {
                    final producto = productosFiltrados[dataIndex];
                    return _buildItemContainer(
                      context,
                      itemData: producto,
                    );
                  } else {
                    return const SizedBox(); // No hay más datos para mostrar
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildItemContainer(
    BuildContext context, {
    required Producto itemData,
  }) {
    final BoxDecoration decoration = BoxDecoration(
      color: bottomNavBar,
      boxShadow: [
        simpleShadow,
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );

    return Stack(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.43,
              height: MediaQuery.of(context).size.width * 0.44,
              decoration: decoration,
              child: _listTile(
                leading: _buildImageProduct(context, itemData.imagen),
                title: Text(itemData.product_code),
                fields: itemData.descriptions,
                category: Text(itemData.category ?? ''),
              ),
            ),
          ],
        ),
      ],
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
    required Widget leading,
    required Widget title,
    required List<DescriptionItem> fields,
    required Widget category,
  }) {
    const rol = UserRoles.admin;
    const bool loggedUserRol = rol == UserRoles.admin;
    return Column(
      children: [
        leading,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Gap(5),
              title,
              ...fields.map(
                (f) => Text(
                  '${f.value}',
                  style: TextStyle(
                    color: smallWordsColor.withOpacity(0.7),
                    fontSize: 8,
                  ),
                ),
              ),
              /*  ...fields.map(
                (f) => Text(
                  '${category}',
                  style: TextStyle(
                    color: smallWordsColor.withOpacity(0.7),
                    fontSize: 6,
                  ),
                ),
               
              ),*/
              Gap(5),
              if (loggedUserRol)
                Container(
                  alignment: Alignment.bottomRight,
                  child: _buildEditButton(),
                )
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
