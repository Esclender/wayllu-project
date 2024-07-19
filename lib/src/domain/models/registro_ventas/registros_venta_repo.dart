// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';

part 'registros_venta_repo.g.dart';

@JsonSerializable()
class VentasList {
  VentasList({
    required this.FECHA_REGISTRO,
    this.CANTIDAD,
    this.DESCRIPCION,
    this.COD_PRODUCTO,
    this.COD_ARTESANA,
    this.CODIGO_REGISTRO,
    this.registrosVentasId,
    this.IMAGEN,
  });

  factory VentasList.fromJson(Map<String, dynamic> json) =>
      _$VentasListFromJson(json);

  int? CANTIDAD;
  String? CODIGO_REGISTRO;
  String FECHA_REGISTRO;
  String? DESCRIPCION;
  String? registrosVentasId;
  String? IMAGEN;
  String? COD_PRODUCTO;
  int? COD_ARTESANA;

  Map<String, dynamic> toJson() => _$VentasListToJson(this);

  Producto toProduct() {
    return Producto(
      imagen: IMAGEN ?? '',
      product_code: '$COD_PRODUCTO',
      descriptions: [
        DescriptionItem(field: 'Descripción', value: DESCRIPCION ?? ''),
        DescriptionItem(field: 'Artesana', value: '$COD_ARTESANA'), 
      ],
    );
  }

  String formattingDate() {
    final DateTime dateTime = DateTime.parse(FECHA_REGISTRO);

    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
}
