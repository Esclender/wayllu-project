// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VentaInfo _$VentaInfoFromJson(Map<String, dynamic> json) => VentaInfo(
      CANTIDAD_TOTAL_PRODUCTOS: json['CANTIDAD_TOTAL_PRODUCTOS'] as int,
      CODIGO_REGISTRO: json['CODIGO_REGISTRO'] as String,
      FECHA_REGISTRO: json['FECHA_REGISTRO'] as String,
      ESTADO: json['ESTADO'] as bool,
      PRODUCTOS: (json['PRODUCTOS'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$VentaInfoToJson(VentaInfo instance) => <String, dynamic>{
      'CANTIDAD_TOTAL_PRODUCTOS': instance.CANTIDAD_TOTAL_PRODUCTOS,
      'CODIGO_REGISTRO': instance.CODIGO_REGISTRO,
      'FECHA_REGISTRO': instance.FECHA_REGISTRO,
      'ESTADO': instance.ESTADO,
      'PRODUCTOS': instance.PRODUCTOS,
    };
