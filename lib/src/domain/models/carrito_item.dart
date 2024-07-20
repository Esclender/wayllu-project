// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';

class CarritoItem {
  ProductInfo info;
  int quantity;

  CarritoItem({
    required this.info,
    required this.quantity,
  });
 double _calculatePrecioVenta() {
    return info.PRECIO * quantity;
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'COD_ARTESANA': info.COD_ARTESANA,
      'COD_PRODUCTO': info.COD_PRODUCTO,
      'PRECIO_VENTA': _calculatePrecioVenta(),
      'DESCRIPCION': info.DESCRIPCION,
      'CATEGORIA': info.CATEGORIA,
      'IMAGEN': info.IMAGEN,
      'CANTIDAD': quantity,
    };
  }
}