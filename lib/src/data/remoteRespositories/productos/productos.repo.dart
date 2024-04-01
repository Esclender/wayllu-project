import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/products_types.dart';

part 'productos.repo.g.dart';

@RestApi(baseUrl: '/api/productos')
abstract class ProductsApiServices {
  factory ProductsApiServices(Dio dio, {String baseUrl}) = _ProductsApiServices;


  @GET('/')
  Future<HttpResponse<ProductsListHttpResponse>> getProducts();
}