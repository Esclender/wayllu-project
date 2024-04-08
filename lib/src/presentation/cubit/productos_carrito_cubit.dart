// ignore_for_file: parameter_assignments

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/domain/models/carrito_item.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';

class ProductsCarrito extends Cubit<List<CarritoItem>> {
  ProductsCarrito() : super([]);

  void addNewProductToCarrito({
    required ProductInfo product,
    int quantity = 0,
  }) {
    //TODO: VALIDATION IF PRODUCT IS NOT ALREADY REGISTER
    if (quantity > 0) {
      state.firstWhere((item) => item.info == product).quantity = quantity;
      emit(List.from(state));
      return;
    }
    state.add(CarritoItem(info: product, quantity: quantity));
    emit(state);
  }

  String get totalItems => state
      .fold<int>(
        0,
        (previousValue, element) => previousValue + element.quantity,
      )
      .toString();
}
