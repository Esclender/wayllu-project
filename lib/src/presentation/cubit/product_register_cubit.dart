import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/dtos/registerProductDto/product_rep.dart';

class ProductRegisterCubit extends Cubit<List<ProductDto>> {
  final ProductsApiRepositoryImpl _productsApiRepositoryImpl;
  ProductRegisterCubit(this._productsApiRepositoryImpl) : super([]);

   Future<void> registerNewProduct(ProductDto producto) async {
    try {
      await _productsApiRepositoryImpl.registerNewProduct(producto.toJson());
      emit([...state, producto]);
    } catch (e) {
      // Manejar el error según sea necesario
      print('Error al registrar el producto: $e');
    }
  }

  void addNewProduct(ProductDto producto) {
    emit([...state, producto]);
  }
  
  void removeAllProducts() {
    emit([]);
  }
}


