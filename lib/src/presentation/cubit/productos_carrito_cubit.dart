// ignore_for_file: parameter_assignments

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:wayllu_project/src/domain/models/carrito_item.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';

class ProductsCarrito extends Cubit<List<CarritoItem>> {
  ProductsCarrito() : super([]);

  void addNewProductToCarrito({
    required ProductInfo product,
    int quantity = 0,
  }) {
    if (quantity > 0) {
      state.firstWhere((item) => item.info == product).quantity = quantity;
      Logger().i(state);
      emit(List.from(state));
      return;
    }

    state.add(CarritoItem(info: product, quantity: quantity));

    emit(state);
  }
}
