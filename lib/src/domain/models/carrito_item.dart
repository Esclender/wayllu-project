import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';

class CarritoItem {
  ProductInfo info;
  int quantity;

  CarritoItem({
    required this.info,
    required this.quantity,
  });
}
