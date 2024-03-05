class ColorfullItem {
  String nombre;
  String url;
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
