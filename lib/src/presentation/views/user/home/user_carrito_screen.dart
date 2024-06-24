// ignore_for_file: avoid_dynamic_calls

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/models/carrito_item.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/domain/models/venta/venta_repo.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/productos_carrito_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class CarritoScreen extends HookWidget {
  final double checkoutBtnHeight = 150.0;
  final appRouter = getIt<AppRouter>();

  Future<VentaInfo?> _checkoutVentaGoRecib(ProductsCarrito carrito) async {
    if (carrito.itemsInCartInt == 0) {
      return null;
    }

    final VentaInfo ventaInfo = await carrito.registerVenta();

    return ventaInfo;
  }

  void _increaseQuantity(
    BuildContext context,
    ProductInfo product,
    int quantity,
  ) {
    context.read<ProductsCarrito>().addNewProductToCarrito(
          product: product,
          quantity: quantity + 1,
        );
  }

  void _decreaseQuantity(
    BuildContext context,
    ProductInfo product,
    int quantity,
  ) {
    context.read<ProductsCarrito>().addNewProductToCarrito(
          product: product,
          quantity: quantity - 1,
        );
  }

  void _removeProduct(
    BuildContext context,
    ProductInfo product,
  ) {
    context.read<ProductsCarrito>().removeProduct(product: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            AutoRouter.of(context).pop();
          },
          child: const Icon(Ionicons.arrow_back),
        ),
        backgroundColor: bgPrimary,
        title: _buildTextHeader(),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: checkoutBtnHeight + 10,
            ),
            child: _buildBlocBuilderWithList(
              context,
            ),
          ),
          _buildConfirmCheckoutBtn(context),
        ],
      ),
    );
  }

  Future<String?> showLoadingDialog(
    BuildContext context,
    ProductsCarrito carrito,
  ) async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        // completer.complete(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              const Text('Cargando...'),
            ],
          ),
        );
      },
    );

    _checkoutVentaGoRecib(carrito).onError((error, stackTrace) {
      appRouter.popForced();
      return null;
    }).then((value) {
      if (value != null) {
        appRouter.navigate(ReciboRoute(ventaInfo: value));
        appRouter.popForced();
      }
    });
  }

  Widget _buildBlocBuilderWithList(BuildContext contextF) {
    return BlocBuilder<ProductsCarrito, List<CarritoItem>>(
      builder: (BuildContext context, list) {
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final carritoCode = list[index];

            return _buildProduct(
              context: context,
              product: carritoCode.info,
              actualValue: carritoCode.quantity,
              increase: () {
                _increaseQuantity(
                  contextF,
                  carritoCode.info,
                  carritoCode.quantity,
                );
              },
              decrease: () {
                _decreaseQuantity(
                  contextF,
                  carritoCode.info,
                  carritoCode.quantity,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildTextHeader() {
    return GradientText(
      text: 'Registro venta',
      fontSize: 25.0,
    );
  }

  Widget _buildProduct({
    required BuildContext context,
    required ProductInfo product,
    required int actualValue,
    required void Function() increase,
    required void Function() decrease,
  }) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bottomNavBar,
      boxShadow: [simpleShadow]),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                product.IMAGEN!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.COD_PRODUCTO.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Gotham',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        iconSize: 22,
                        onPressed: () {
                          _removeProduct(context, product);
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  product.DESCRIPCION,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontFamily: 'Gotham',
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuantityControl(
                      increase: increase,
                      decrease: decrease,
                      value: actualValue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl({
    required int value,
    required void Function() increase,
    required void Function() decrease,
  }) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF919191),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
            ),
            iconSize: 15,
            onPressed: decrease,
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Gotham',
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 15,
            onPressed: increase,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmCheckoutBtn(BuildContext context) {
    final itemsInCart = context.watch<ProductsCarrito>();

    return Container(
      height: checkoutBtnHeight,
      color: bgContainer,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'N° productos agregados:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Gotham',
                  color: subtxtColor,
                ),
              ),
              Text(
                itemsInCart.totalItems,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Gotham',
                  color: subtxtColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              showLoadingDialog(context, itemsInCart);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: thirdColor,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            child: Text(
              'Registrar Venta',
              style: TextStyle(
                fontFamily: 'Gotham',
                fontSize: 16,
                color: bgContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
