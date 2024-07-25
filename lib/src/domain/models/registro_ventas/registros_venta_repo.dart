// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/domain/models/venta/ventas_excel/ventas_excel.dart';

part 'registros_venta_repo.g.dart';

@JsonSerializable()
class VentasList {
  VentasList({
    required this.FECHA_REGISTRO,
    required this.CANTIDAD,
    required this.COD_PRODUCTO,
    required this.CATEGORIA_PRODUCTO,
    required this.NOMBRE_ARTESANO,
    required this.PRECIO_VENTA,
    required this.MONTO_TOTAL,
    required this.DESCRIPCION,
    required this.COMUNIDAD,
    this.COD_ARTESANA,
    this.CODIGO_REGISTRO,
    this.registrosVentasId,
    this.IMAGEN,
  });

  factory VentasList.fromJson(Map<String, dynamic> json) =>
      _$VentasListFromJson(json);

  String? registrosVentasId;
  String? CODIGO_REGISTRO;
  String? IMAGEN;
  int? COD_ARTESANA;
  int CANTIDAD;
  String FECHA_REGISTRO;
  String DESCRIPCION;
  String CATEGORIA_PRODUCTO;
  String COMUNIDAD;
  String NOMBRE_ARTESANO;
  String COD_PRODUCTO;
  double PRECIO_VENTA;
  double MONTO_TOTAL;

  Map<String, dynamic> toJson() => _$VentasListToJson(this);

  Producto toProduct() {
    return Producto(
      imagen: IMAGEN ?? '',
      product_code: COD_PRODUCTO,
      descriptions: [
        DescriptionItem(field: 'Descripción', value: DESCRIPCION),
        DescriptionItem(field: 'Artesana', value: '$COD_ARTESANA'),
      ],
    );
  }

  SalesData toSalesData() {
    return SalesData(
      date: formattingDate(),
      productCode: COD_PRODUCTO,
      artisan: NOMBRE_ARTESANO,
      community: COMUNIDAD,
      categoryProduct: CATEGORIA_PRODUCTO,
      family: DESCRIPCION,
      quantity: CANTIDAD,
      amount: MONTO_TOTAL,
      unitPrice: PRECIO_VENTA,
    );
  }

  String formattingDate() {
    final DateTime dateTime = DateTime.parse(FECHA_REGISTRO);

    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
}
