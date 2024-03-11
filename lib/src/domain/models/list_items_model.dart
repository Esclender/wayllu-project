import 'dart:math';

class ColorfullItem {
  String nombre;
  String url;
  int gradient = Random().nextInt(3);
  List<DescriptionItem> descriptions;

  ColorfullItem({
    required this.nombre,
    required this.url,
    required this.descriptions,
  });
}

class DescriptionItem {
  String field;
  String value;

  DescriptionItem({
    required this.field,
    required this.value,
  });
}
