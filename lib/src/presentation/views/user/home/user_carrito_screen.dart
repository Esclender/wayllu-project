// ignore_for_file: avoid_dynamic_calls

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logger/logger.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/models/carrito_item.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/productos_carrito_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class CarritoScreen extends HookWidget {
  final double checkoutBtnHeight = 150.0;
  final appRouter = getIt<AppRouter>();

  void _checkoutVentaGoRecib() {
    appRouter.navigate(const ReciboRoute());
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

  Widget _buildBlocBuilderWithList(BuildContext contextF) {
    // final listCarritoItem = context.watch<ProductsCarrito>();

    return BlocBuilder<ProductsCarrito, List<CarritoItem>>(
      builder: (BuildContext context, list) {
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final carritoItem = list[index];

            return _buildProduct(
              productName: carritoItem.info.ITEM.toString(),
              productDescription: carritoItem.info.DESCRIPCION,
              productImage: carritoItem.info.IMAGEN!,
              actualValue: carritoItem.quantity,
              increase: () {
                _increaseQuantity(
                  contextF,
                  carritoItem.info,
                  carritoItem.quantity,
                );
              },
              decrease: () {
                _decreaseQuantity(
                  contextF,
                  carritoItem.info,
                  carritoItem.quantity,
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
    required String productName,
    required String productDescription,
    required String productImage,
    required int actualValue,
    required void Function() increase,
    required void Function() decrease,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 110,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              productImage,
              width: 100,
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
                      productName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Gotham',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 18,
                      onPressed: () {
                        // Add logic to remove item from cart
                      },
                    ),
                  ],
                ),
              ),
              Text(
                productDescription,
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
            onPressed: _checkoutVentaGoRecib,
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
