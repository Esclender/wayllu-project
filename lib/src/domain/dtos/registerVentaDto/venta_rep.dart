// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'venta_rep.g.dart';

@JsonSerializable()
class VentaDto extends Equatable {
  const VentaDto({
    required this.CANTIDAD_TOTAL_PRODUCTOS,
    required this.PRODUCTOS,
  });

  final int CANTIDAD_TOTAL_PRODUCTOS;
  final List PRODUCTOS;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CANTIDAD_TOTAL_PRODUCTOS': CANTIDAD_TOTAL_PRODUCTOS,
      'PRODUCTOS': PRODUCTOS,
    };
  }

  factory VentaDto.fromMap(Map<String, dynamic> map) {
    return VentaDto(
      CANTIDAD_TOTAL_PRODUCTOS: map['CANTIDAD_TOTAL_PRODUCTOS'] as int,
      PRODUCTOS: List.from(
        map['PRODUCTOS'] as List,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory VentaDto.fromJson(String source) =>
      VentaDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [CANTIDAD_TOTAL_PRODUCTOS, PRODUCTOS];
}
