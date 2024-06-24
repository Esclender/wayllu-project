// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: non_constant_identifier_names
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';

part 'product_info_model.g.dart';

@JsonSerializable()
class ProductInfo {
  ProductInfo({
    required this.id,
    required this.COD_PRODUCTO,
    required this.ITEM,
    required this.DESCRIPCION,
    required this.COD_FAMILIA,
    required this.COD_ARTESANA,
    required this.COD_ORDEN_PRO,
    required this.CANTIDAD,
    required this.CATEGORIA,
    required this.TIPO_PESO,
    required this.FECHA_INGRESO,
    this.UBICACION,
    this.PESO,
    this.IMAGEN,
    this.ANCHO,
    this.ALTO,
  });

  static Map<String, dynamic> convertoToBodyRequest(Map<String, dynamic> json) {
    return {
      'id': json['id'],
      'UBICACION': json['UBICACION'],
      'COD_ARTESANA': int.parse(json['ARTESANO'] as String),
      'PESO': int.parse(json['PESO'] as String),
      'TIPO_PESO': json['TIPO_PESO'],
      'ALTO': int.parse(json['ALTO'] as String),
      'ANCHO': int.parse(json['ANCHO'] as String),
      'CATEGORIA': json['CATEGORIA'],
      'COD_FAMILIA': int.parse(json['COD_FAMILIA'] as String),
    };
  }

  List<DescriptionItem> get descriptionsFields => [
        DescriptionItem(field: 'Descripción', value: DESCRIPCION),
      ];

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

  String id;
  String COD_PRODUCTO;
  int ITEM;
  String DESCRIPCION;
  int COD_FAMILIA;
  int COD_ARTESANA;
  int COD_ORDEN_PRO;
  int? CANTIDAD;
  String CATEGORIA;
  String TIPO_PESO;
  String? FECHA_INGRESO;
  String? UBICACION;
  int? PESO;
  String? IMAGEN;
  int? ANCHO;
  int? ALTO;

  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);

  String getCategoryName() {
    return CATEGORIA;
  }

  Producto toProduct() {
    return Producto(
      imagen: IMAGEN ?? '',
      product_code: COD_PRODUCTO,
      descriptions: [
        DescriptionItem(field: 'Descripción', value: DESCRIPCION),
      ],
      category: CATEGORIA,
    );
  }

  String get category => CATEGORIA;

  MoreInfo get productInfo => MoreInfo(
        COD_PRODUCTO: COD_PRODUCTO,
        DESCRIPCION: DESCRIPCION,
        CATEGORIA: CATEGORIA,
      );

  String formattingDate() {
    final DateTime dateTime = DateTime.parse(FECHA_INGRESO ?? '');

    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
}

abstract class InfoBase {
  List<List> get entries => [];
}

class MoreInfo extends InfoBase {
  String COD_PRODUCTO;
  String DESCRIPCION;
  String CATEGORIA;

  MoreInfo({
    required this.COD_PRODUCTO,
    required this.DESCRIPCION,
    required this.CATEGORIA,
  });
}
