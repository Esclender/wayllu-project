class CardTemplate {
  String nombre;
  String url;
  int? codigoArtesano;
  List<DescriptionItem> descriptions;

  CardTemplate({
    required this.nombre,
    required this.url,
    required this.descriptions,
    this.codigoArtesano,
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
