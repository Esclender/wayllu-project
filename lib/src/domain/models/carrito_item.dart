import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';

class CarritoItem {
  ProductInfo info;
  int quantity;
  void Function() increase;
  void Function() decrease;

  CarritoItem({
    required this.info,
    required this.quantity,
    required this.decrease,
    required this.increase,
  });
}
