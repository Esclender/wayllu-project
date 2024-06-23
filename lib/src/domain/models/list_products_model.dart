import 'package:wayllu_project/src/domain/models/list_items_model.dart';

class CardTemplateProducts {
  String nombre;
  String url;
  int? codigoArtesano;
  List<DescriptionItem> descriptions;

  CardTemplateProducts({
    required this.nombre,
    required this.url,
    required this.descriptions,
    this.codigoArtesano,
  });
}