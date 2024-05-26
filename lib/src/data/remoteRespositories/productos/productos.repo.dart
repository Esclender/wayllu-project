import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/domain/models/registro_ventas/registros_venta_repo.dart';
import 'package:wayllu_project/src/domain/models/venta/venta_repo.dart';
import 'package:wayllu_project/src/domain/repositories/types/products_types.dart';
import 'package:wayllu_project/src/domain/repositories/types/ventas_types.dart';

part 'productos.repo.g.dart';

@RestApi(baseUrl: '/api/productos')
abstract class ProductsApiServices {
  factory ProductsApiServices(Dio dio, {String baseUrl}) = _ProductsApiServices;

  @GET('/')
  Future<HttpResponse<ProductsListHttpResponse>> getProducts(
    @Query('codigo_producto') String? codigoProducto,
  );

  @POST('/registro')
  Future<HttpResponse<void>> newProducto(
    @Body() Map<String, dynamic> productInfo,
  );

  @POST('/venta')
  Future<HttpResponse<VentaInfo>> newVenta(
    @Body() Map<String, dynamic> ventaData,
  );
  @GET('/ventas')
  Future<HttpResponse<VentasListHttpResponse>> getVentas();

  @GET('/ventas/{year}/{mes}')
  Future<HttpResponse<VentasListHttpResponse>> getVentasByYearAndMonth(
    @Path('year') String? year,
    @Path('mes') String? mes,
  );
}
