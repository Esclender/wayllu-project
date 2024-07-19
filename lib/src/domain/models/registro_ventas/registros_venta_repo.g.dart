// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registros_venta_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VentasList _$VentasListFromJson(Map<String, dynamic> json) => VentasList(
      FECHA_REGISTRO: json['FECHA_REGISTRO'] as String,
      CANTIDAD: json['CANTIDAD'] as int?,
      DESCRIPCION: json['DESCRIPCION'] as String?,
      COD_PRODUCTO: json['COD_PRODUCTO'] as String?,
      COD_ARTESANA: json['COD_ARTESANA'] as int?,
      CODIGO_REGISTRO: json['CODIGO_REGISTRO'] as String?,
      registrosVentasId: json['registrosVentasId'] as String?,
      IMAGEN: json['IMAGEN'] as String?,
    );

Map<String, dynamic> _$VentasListToJson(VentasList instance) =>
    <String, dynamic>{
      'CANTIDAD': instance.CANTIDAD,
      'CODIGO_REGISTRO': instance.CODIGO_REGISTRO,
      'FECHA_REGISTRO': instance.FECHA_REGISTRO,
      'DESCRIPCION': instance.DESCRIPCION,
      'registrosVentasId': instance.registrosVentasId,
      'IMAGEN': instance.IMAGEN,
      'COD_PRODUCTO': instance.COD_PRODUCTO,
      'COD_ARTESANA': instance.COD_ARTESANA,
    };
