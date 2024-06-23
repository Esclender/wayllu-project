import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';

class CardTemplate {
  String nombre;
  String url;
  int? codigoArtesano;
  List<DescriptionItem> descriptions;
   UserInfo userInfo;

  CardTemplate({
    required this.nombre,
    required this.url,
    required this.descriptions,
    this.codigoArtesano,
    required this.userInfo,
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

