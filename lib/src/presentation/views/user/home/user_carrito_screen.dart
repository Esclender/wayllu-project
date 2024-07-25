// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  final appRouter = getItAppRouter<AppRouter>();

  Future<VentaInfo?> _checkoutVentaGoRecib(ProductsCarrito carrito) async {
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

  Future<void> showLoadingDialog(
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
      showSometgingWrongDialog(context);

      return null;
    }).then((value) {
      if (value != null) {
        appRouter.navigate(ReciboRoute(ventaInfo: value));
        appRouter.popForced();
      }
    });
  }

  void showSometgingWrongDialog(
    BuildContext context,
  ) {
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
              Icon(
                Ionicons.warning_outline,
                size: 32,
                color: HexColor('#B80000'),
              ),
              const SizedBox(height: 20),
              const Text('No se logro completar el registro!'),
            ],
          ),
        );
      },
    );

    Timer(const Duration(seconds: 2), () {
      appRouter.popForced();
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
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bottomNavBar,
        boxShadow: [simpleShadow],
      ),
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
          const SizedBox(width: 12),
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
                        product.COD_PRODUCTO,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 25, 25, 25),
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
                    Text(
                      'S/${product.PRECIO}',
                      style: TextStyle(fontSize: 18, color: iconColor),
                    ),
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
      margin: const EdgeInsets.only(right: 10),
      height: 30,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: const Color(0xFF919191),
      //   ),
      //   borderRadius: BorderRadius.circular(5),
      // ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: bottomNavBarStroke,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: decrease,
              child: Icon(
                Icons.remove,
                size: 18,
                color: bottomNavBar,
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          SizedBox(
            width: 25,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Gotham',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: bottomNavBarStroke,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: increase,
              child: Icon(
                Icons.add,
                size: 18,
                color: bottomNavBar,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmCheckoutBtn(BuildContext context) {
    final carrito = context.watch<ProductsCarrito>();

    return Container(
      height: checkoutBtnHeight,
      decoration: BoxDecoration(
        color: bgContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 33, 33, 33)
                .withOpacity(0.1), // Color de la sombra
            // offset: Offset(0, -1), // Desplazamiento en el eje y
            blurRadius: 6, // Radio de desenfoque
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Gotham',
                  color: iconColor,
                ),
              ),
              Text(
                'S/${carrito.totalPrice.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Gotham',
                  color: iconColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                carrito.totalItems,
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                if (carrito.itemsInCartInt != 0) {
                  showLoadingDialog(context, carrito);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: thirdColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
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
          ),
        ],
      ),
    );
  }
}
