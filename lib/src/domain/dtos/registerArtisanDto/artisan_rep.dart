// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artisan_rep.g.dart';

@JsonSerializable()
class ArtesanoDto extends Equatable {
  final String NOMBRE_COMPLETO;
  final int DNI;
  final String COMUNIDAD;
  final int CDG_COMUNIDAD;
  final String CLAVE;
  final int CODIGO;
  final String URL_IMAGE;
  final String ROL;

  ArtesanoDto({
    required this.NOMBRE_COMPLETO,
    required this.DNI,
    required this.COMUNIDAD,
    required this.CDG_COMUNIDAD,
    required this.CLAVE,
    required this.CODIGO,
    required this.URL_IMAGE,
    required this.ROL,
  });

  // Método toJson usando json_serializable
  Map<String, dynamic> toJson() => _$ArtesanoDtoToJson(this);

  // Método fromJson usando json_serializable
  factory ArtesanoDto.fromJson(Map<String, dynamic> json) => _$ArtesanoDtoFromJson(json);

  @override
  List<Object?> get props => [
        NOMBRE_COMPLETO,
        DNI,
        COMUNIDAD,
        CDG_COMUNIDAD,
        CLAVE,
        CODIGO,
        URL_IMAGE,
        ROL,
      ];
}