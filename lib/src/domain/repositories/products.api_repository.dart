import 'package:wayllu_project/src/domain/models/venta/venta_repo.dart';
import 'package:wayllu_project/src/domain/repositories/types/products_types.dart';
import 'package:wayllu_project/src/domain/repositories/types/ventas_types.dart';

abstract class ProductRepository {
  //Aqui iran todos los metodos para llamar a los endpoints de api
  //Modificar los returns de acuerdo a que se devolvera
  Future<ProductsListHttpResponse> getProducts(String? codigoProducto);
  Future<void> newProduct(Map<String, dynamic> productInfo);
  Future<VentaInfo> newVenta(Map<String, dynamic> ventaData);
  Future<VentasListHttpResponse> getVentas();
}
