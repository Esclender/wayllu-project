// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: non_constant_identifier_names
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:wayllu_project/src/domain/models/carrito_item.dart';
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
    this.IMAGEN,
  });

  factory VentaInfo.fromJson(Map<String, dynamic> json) =>
      _$VentaInfoFromJson(json);

  int CANTIDAD_TOTAL_PRODUCTOS;
  String CODIGO_REGISTRO;
  String FECHA_REGISTRO;
  String? IMAGEN;
  bool ESTADO;
  List<Map<String, dynamic>> PRODUCTOS;

  Map<String, dynamic> toJson() => _$VentaInfoToJson(this);


  String formattingDate() {
    final DateTime dateTime = FECHA_REGISTRO != null
        ? DateTime.parse(FECHA_REGISTRO ?? '')
        : DateTime.now();

    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }

}

