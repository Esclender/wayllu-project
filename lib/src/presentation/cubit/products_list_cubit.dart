import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/domain/repositories/types/products_types.dart';

class ProductListCubit extends Cubit<List<Producto>?> {
  final ProductsApiRepositoryImpl _apiRepository;

  ProductListCubit(this._apiRepository) : super(null);

  Future<void> getUserLists({int pagina = 1}) async {
    final ProductsListHttpResponse responseState =
        await _apiRepository.getProducts();

    emit(
      state == null
          ? responseState?.map((user) => user.toProduct()).toList()
          : [
              ...state!,
              ...responseState!.map((user) => user.toProduct()),
            ],
    );
  }
}