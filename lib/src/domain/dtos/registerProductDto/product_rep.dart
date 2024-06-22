// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_rep.g.dart';

@JsonSerializable()
class ProductDto extends Equatable {
  final int ANCHO;
  final int ALTO;
  final String TIPO_PESO;
  final int PESO;
  final String CATEGORIA;
  final String IMAGEN;
  final String DESCRIPCION;
  final int COD_FAMILIA;
  final int COD_ARTESANA;
  final String COD_PRODUCTO;
  final String UBICACION;
  final int CANTIDAD;

  ProductDto({
    required this.ANCHO,
    required this.ALTO,
    required this.TIPO_PESO,
    required this.PESO,
    required this.CATEGORIA,
    required this.IMAGEN,
    required this.DESCRIPCION,
    required this.COD_FAMILIA,
    required this.COD_ARTESANA,
    required this.COD_PRODUCTO,
    required this.UBICACION,
    required this.CANTIDAD,
  });

  // Método toJson usando json_serializable
  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  // Método fromJson usando json_serializable
  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  @override
  List<Object?> get props => [
        ANCHO,
        ALTO,
        TIPO_PESO,
        PESO,
        CATEGORIA,
        IMAGEN,
        DESCRIPCION,
        COD_FAMILIA,
        COD_ARTESANA,
        COD_PRODUCTO,
        UBICACION,
        CANTIDAD,
      ];
}
