import 'dart:math';

import 'package:wayllu_project/src/providers/user_provider.dart';

class CardTemplate {
  String nombre;
  String url;
  List<DescriptionItem> descriptions;

  CardTemplate({
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
