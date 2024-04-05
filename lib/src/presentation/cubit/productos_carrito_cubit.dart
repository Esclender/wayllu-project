// ignore_for_file: parameter_assignments

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/domain/models/carrito_item.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';

class ProductsCarrito extends Cubit<List<CarritoItem>> {
  ProductsCarrito() : super([]);

  Future<void> addNewProductToCarrito({
    required ProductInfo product,
    int quantity = 0,
  }) async {
    final productToAdd = CarritoItem(
      info: product,
      quantity: quantity,
      decrease: () {
        addNewProductToCarrito(product: product, quantity: quantity++);
      },
      increase: () {
        if (quantity > 0) {
          addNewProductToCarrito(product: product, quantity: quantity--);
        }
      },
    );

    emit(
      [
        ...super.state,
        productToAdd,
      ],
    );
  }
}
