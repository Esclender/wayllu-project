class Producto {
  final String imagen;
  final String name;
  final String description;
  final double price;

  Producto({
    required this.imagen,
    required this.name,
    required this.description,
    required this.price,
  });
}

final List<Producto> productos = [
  Producto(
    imagen: 'assets/images/product/chullo.jpg',
    name: 'Chullo',
    description: 'Descripción del Producto 1',
    price: 20.0,
  ),
  Producto(
    imagen: 'assets/images/product/gorro-multicolor2.jpg',
    name: 'Producto 2',
    description: 'Descripción del Producto 2',
    price: 25.0,
  ),
  Producto(
    imagen: 'assets/images/product/Poncho-rojo.jpg',
    name: 'Producto 3',
    description: 'Descripción del Producto 2',
    price: 25.0,
  ),
  Producto(
    imagen: 'assets/images/product/poncho-w&b.jpg',
    name: 'Producto 4',
    description: 'Descripción del Producto 2',
    price: 25.0,
  ),
  Producto(
    imagen: 'assets/images/product/chullo.jpg',
    name: 'Chullo',
    description: 'Descripción del Producto 1',
    price: 20.0,
  ),
  Producto(
    imagen: 'assets/images/product/gorro-multicolor2.jpg',
    name: 'Producto 2',
    description: 'Descripción del Producto 2',
    price: 25.0,
  ),
  Producto(
    imagen: 'assets/images/product/Poncho-rojo.jpg',
    name: 'Producto 3',
    description: 'Descripción del Producto 2',
    price: 25.0,
  ),
  Producto(
    imagen: 'assets/images/product/poncho-w&b.jpg',
    name: 'Producto 4',
    description: 'Descripción del Producto 2',
    price: 25.0,
  ),
  // Agrega más productos según sea necesario
];
