import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/enums/user_roles.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/productos_carrito_cubit.dart';
import 'package:wayllu_project/src/presentation/cubit/user_logged_cubit.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class ProductsCardsItemsList extends HookWidget {
  final BuildContext context;
  final ListEnums listType;
  final List<ProductInfo> dataToRender;
  final String query;
  final ScrollController? scrollController;
  final String? categoriaSeleccionada;

  final appRouter = getIt<AppRouter>();

  ProductsCardsItemsList({
    required this.context,
    required this.listType,
    required this.dataToRender,
    this.query = '',
    this.categoriaSeleccionada,
    this.scrollController,
  });

  void _addItemToCarrito(ProductInfo product) {
    context.read<ProductsCarrito>().addNewProductToCarrito(
          product: product,
        );
  }

  @override
  Widget build(BuildContext context) {
    final rol = context.read<UserLoggedCubit>().state;

    // final productosFiltrados = categoriaSeleccionada != null
    //     ? dataToRender
    //         .where((producto) => producto.category == categoriaSeleccionada)
    //         .toList()
    //     : dataToRender;

    return _buildProducts(dataToRender, rol);
  }

  Widget _buildProducts(
    List<ProductInfo> productosFiltrados,
    UserRoles rol,
  ) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productosFiltrados.length,
      itemBuilder: (BuildContext context, int index) {
        final producto = productosFiltrados[index];
        return _buildItemContainer(
          context,
          itemData: producto,
          rol: rol,
        );
      },
    );
  }

  Widget _buildItemContainer(
    BuildContext context, {
    required ProductInfo itemData,
    required UserRoles rol,
  }) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.43,
              height: double.infinity,
              decoration: BoxDecoration(
                color: bottomNavBar,
                boxShadow: [
                  simpleShadow,
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: _buildListTile(context, itemData, rol),
            ),
            if (rol == UserRoles.artesano)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                  onPressed: () {
                    _addItemToCarrito(itemData);
                  },
                  icon: const Icon(
                    Ionicons.add,
                    size: 24,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context,
    ProductInfo itemData,
    UserRoles rol,
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
      height: MediaQuery.of(context).size.width * 0.36,
      decoration: decoration,
      child: _listTile(
        context: context,
        rol: rol,
        productInfo: itemData,
        leading: _buildImageProduct(context, itemData.IMAGEN!),
        title: Text(itemData.COD_PRODUCTO),
        fields: itemData.descriptionsFields,
        category: Text(itemData.category),
      ),
    );
  }

  Widget _buildImageProduct(BuildContext context, String url) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.25,
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
    required ProductInfo productInfo,
    required List<DescriptionItem> fields,
    required Widget category,
    required UserRoles rol,
  }) {
    final bool loggedUserRol = rol == UserRoles.admin;

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
                  ...fields.map(
                    (f) => Text(
                      f.value,
                      style: TextStyle(
                        color: smallWordsColor.withOpacity(0.7),
                        fontSize: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Gap(8),
        if (loggedUserRol)
          Container(
            margin: const EdgeInsets.only(right: 4),
            alignment: Alignment.bottomRight,
            child: _buildEditButton(
              productInfo: productInfo,
            ),
          ),
      ],
    );
  }

  Container _buildEditButton({
    required ProductInfo productInfo,
  }) {
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
        onTap: () {
          appRouter.navigate(EditProductsRoute(productInfo: productInfo));
        },
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
