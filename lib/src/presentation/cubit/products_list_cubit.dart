import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/products_types.dart';

class ProductListCubit extends Cubit<List<ProductInfo>?> {
  final ProductsApiRepositoryImpl _apiRepository;

  ProductListCubit(this._apiRepository) : super(null);

  Future<void> getProductsLists({int pagina = 1, String codigo = ''}) async {
    final ProductsListHttpResponse responseState =
        await _apiRepository.getProducts(pagina: pagina);

    Logger().i(responseState);

    emit(
      state == null
          ? responseState?.map((producto) => producto).toList()
          : pagina == 1
              ? [
                  ...responseState!.map((producto) => producto),
                ]
              : [
                  ...state!,
                  ...responseState!.map((producto) => producto),
                ],
    );
  }

  Future<void> registerNewProduct(Map<String, dynamic> productInfo) async {
    await _apiRepository.newProduct(productInfo);
  }

  Future<void> updateProduct(Map<String, dynamic> productInfo) async {
    await _apiRepository.updateProduct(productInfo);
  }

  Future<void> getProductsListsByCode(String? productCode) async {
    final ProductsListHttpResponse responseState =
        await _apiRepository.getProducts(codigoProducto: productCode);

    emit(responseState?.map((producto) => producto).toList());
  }
}
