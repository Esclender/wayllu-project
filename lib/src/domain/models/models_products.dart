
import 'package:wayllu_project/src/domain/models/list_items_model.dart';

class Producto {
  final String imagen;
  final String product_code;
  List<DescriptionItem> descriptions;
  final String? category;

  Producto({
    required this.imagen,
    required this.product_code,
    required this.descriptions,
    this.category,
  });
}

class Categories {
  final String image;
  final String name;
  final String categoryName; // Nombre de la categoría específica
  Categories({
    required this.image,
    required this.name,
    required this.categoryName,
  });
}

final List<Categories> categories = [
  Categories(
    image: 'assets/images/product/manto-category.png',
    name: 'Textiles para el hogar',
    categoryName: 'TEXTILES PARA EL HOGAR', // Nombre de la categoría específica
  ),
  Categories(
    image: 'assets/images/product/accesorios-category.png',
    name: 'Accesorios',
    categoryName: 'ACCESORIOS', // Nombre de la categoría específica
  ),
  Categories(
    image: 'assets/images/product/bolso-category.png',
    name: 'Bolsos y Monederos',
    categoryName: 'BOLSOS Y MONEDEROS', // Nombre de la categoría específica
  ),
];

// Crear un mapa que mapee los nombres de categorías a las categorías correspondientes
final Map<String, Categories> categoriesMap = {
  'TEXTILES PARA EL HOGAR': categories[0],
  'ACCESORIOS': categories[1],
  'BOLSOS Y MONEDEROS': categories[2],
};

// Utilizar las claves del mapa para definir el enum Category
enum Category {
  TEXTILES_PARA_EL_HOGAR,
  ACCESORIOS,
  BOLSOS_Y_MONEDEROS,
}
