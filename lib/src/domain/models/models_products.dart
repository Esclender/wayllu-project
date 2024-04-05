import 'package:wayllu_project/src/domain/models/list_items_model.dart';

class Producto {
  final String imagen;
  final String product_code;
  List<DescriptionItem> descriptions;

  Producto({
    required this.imagen,
    required this.product_code,
    required this.descriptions,
  });
}

class Categories {
  final String image;
  final String name;

  Categories({
    required this.image,
    required this.name,
  });
}

final List<Categories> categories = [
  Categories(
    image: 'assets/images/product/gorro-category.png',
    name: 'Textiles para el hogar',
  ),
  Categories(
    image: 'assets/images/product/poncho-category.png',
    name: 'Accesorios',
  ),
  Categories(
    image: 'assets/images/product/manto-category.png',
    name: 'Bolsos y Monederos',
  ),
];
