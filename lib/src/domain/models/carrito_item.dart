// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';

class CarritoItem {
  ProductInfo info;
  int quantity;

  CarritoItem({
    required this.info,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'COD_PRODUCTO': info.COD_PRODUCTO,
      'DESCRIPCION': info.DESCRIPCION,
      'CATEGORIA': info.CATEGORIA,
      'IMAGEN': info.IMAGEN,
      'CANTIDAD': quantity,
    };
  }
}