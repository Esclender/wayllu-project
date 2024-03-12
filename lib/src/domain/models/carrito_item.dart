import 'package:wayllu_project/src/domain/models/models_products.dart';

class CarritoItem {
  Producto item;
  int quantity;

  CarritoItem({
    required this.item,
    required this.quantity,
  });

  String get totalToString => 'S/ ${item.price * quantity}';
}
