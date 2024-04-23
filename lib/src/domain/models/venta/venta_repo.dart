// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'venta_repo.g.dart';

@JsonSerializable()
class VentaInfo {
  VentaInfo({
    required this.CANTIDAD_TOTAL_PRODUCTOS,
    required this.CODIGO_REGISTRO,
    required this.FECHA_REGISTRO,
    required this.ESTADO,
    required this.PRODUCTOS,
  });

  factory VentaInfo.fromJson(Map<String, dynamic> json) =>
      _$VentaInfoFromJson(json);

  int CANTIDAD_TOTAL_PRODUCTOS;
  String CODIGO_REGISTRO;
  String FECHA_REGISTRO;
  bool ESTADO;
  List<Map<String, dynamic>> PRODUCTOS;

  Map<String, dynamic> toJson() => _$VentaInfoToJson(this);
}
