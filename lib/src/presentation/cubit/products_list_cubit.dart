import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/domain/repositories/types/products_types.dart';

class ProductListCubit extends Cubit<List<Producto>?> {
  final ProductsApiRepositoryImpl _apiRepository;

  ProductListCubit(this._apiRepository) : super(null);

  Future<void> getProductsLists() async {
    final ProductsListHttpResponse responseState =
        await _apiRepository.getProducts();

    emit(
      state == null
          ? responseState?.map((producto) => producto.toProduct()).toList()
          : [
              ...state!,
              ...responseState!.map((producto) => producto.toProduct()),
            ],
    );
  }
}