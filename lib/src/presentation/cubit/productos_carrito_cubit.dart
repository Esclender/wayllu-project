// ignore_for_file: parameter_assignments

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/carrito_item.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/domain/models/venta/venta_repo.dart';

class ProductsCarrito extends Cubit<List<CarritoItem>> {
  final ProductsApiRepositoryImpl _productsApiServices;
  ProductsCarrito(this._productsApiServices) : super([]);

  Future<VentaInfo> registerVenta() async {
    final ventaInfo = await _productsApiServices.newVenta({
      'CANTIDAD_TOTAL_PRODUCTOS': itemsInCartInt,
      'PRODUCTOS': mappedCarritoItems,
    });

    return ventaInfo;
  }

  void addNewProductToCarrito({
    required ProductInfo product,
    int quantity = 0,
  }) {
    if (state.any((element) => element.info.ITEM == product.ITEM) &&
        quantity == 0) {
      return;
    }

    if (quantity > 0) {
      state.firstWhere((item) => item.info == product).quantity = quantity;
      emit(List.from(state));
      return;
    }
    state.add(CarritoItem(info: product, quantity: 1));
    emit(List.from(state));
  }

  void removeProduct({
    required ProductInfo product,
  }) {
    state.removeWhere((item) => item.info.ITEM == product.ITEM);
    emit(List.from(state));
  }

  void removeAll() {
    emit([]);
  }

  String get totalItems => state
      .fold<int>(
        0,
        (previousValue, element) => previousValue + element.quantity,
      )
      .toString();

  String get itemsInCart => state.length.toString();
  int get itemsInCartInt => state.length;
  List<Map<String, dynamic>> get mappedCarritoItems {
    return state.map((e) => e.toMap()).toList();
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in state) {
      totalPrice += item.info.PRECIO * item.quantity;
    }
    return totalPrice;
  }

  double get totalPrice => calculateTotalPrice();
}
