// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registros_venta_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VentasList _$VentasListFromJson(Map<String, dynamic> json) => VentasList(
      FECHA_REGISTRO: json['FECHA_REGISTRO'] as String,
      CANTIDAD: json['CANTIDAD'] as int,
      COD_PRODUCTO: json['COD_PRODUCTO'] as String,
      CATEGORIA_PRODUCTO: json['CATEGORIA_PRODUCTO'] as String,
      NOMBRE_ARTESANO: json['NOMBRE_ARTESANO'] as String,
      PRECIO_VENTA: (json['PRECIO_VENTA'] as num).toDouble(),
      MONTO_TOTAL: (json['MONTO_TOTAL'] as num).toDouble(),
      DESCRIPCION: json['DESCRIPCION'] as String,
      COMUNIDAD: json['COMUNIDAD'] as String,
      COD_ARTESANA: json['COD_ARTESANA'] as int?,
      CODIGO_REGISTRO: json['CODIGO_REGISTRO'] as String?,
      registrosVentasId: json['registrosVentasId'] as String?,
      IMAGEN: json['IMAGEN'] as String?,
    );

Map<String, dynamic> _$VentasListToJson(VentasList instance) =>
    <String, dynamic>{
      'registrosVentasId': instance.registrosVentasId,
      'CODIGO_REGISTRO': instance.CODIGO_REGISTRO,
      'IMAGEN': instance.IMAGEN,
      'COD_ARTESANA': instance.COD_ARTESANA,
      'CANTIDAD': instance.CANTIDAD,
      'FECHA_REGISTRO': instance.FECHA_REGISTRO,
      'DESCRIPCION': instance.DESCRIPCION,
      'CATEGORIA_PRODUCTO': instance.CATEGORIA_PRODUCTO,
      'COMUNIDAD': instance.COMUNIDAD,
      'NOMBRE_ARTESANO': instance.NOMBRE_ARTESANO,
      'COD_PRODUCTO': instance.COD_PRODUCTO,
      'PRECIO_VENTA': instance.PRECIO_VENTA,
      'MONTO_TOTAL': instance.MONTO_TOTAL,
    };
