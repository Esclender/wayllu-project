// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      id: json['id'] as String,
      COD_PRODUCTO: json['COD_PRODUCTO'] as String,
      ITEM: json['ITEM'] as int,
      DESCRIPCION: json['DESCRIPCION'] as String,
      COD_FAMILIA: json['COD_FAMILIA'] as int,
      COD_ARTESANA: json['COD_ARTESANA'] as int,
      COD_ORDEN_PRO: json['COD_ORDEN_PRO'] as int,
      CANTIDAD: json['CANTIDAD'] as int?,
      CATEGORIA: json['CATEGORIA'] as String,
      TIPO_PESO: json['TIPO_PESO'] as String,
      FECHA_INGRESO: json['FECHA_INGRESO'] as String?,
      UBICACION: json['UBICACION'] as String?,
      PESO: (json['PESO'] as num?)?.toDouble(),
      IMAGEN: json['IMAGEN'] as String?,
      ANCHO: json['ANCHO'] as int?,
      ALTO: json['ALTO'] as int?,
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'COD_PRODUCTO': instance.COD_PRODUCTO,
      'ITEM': instance.ITEM,
      'DESCRIPCION': instance.DESCRIPCION,
      'COD_FAMILIA': instance.COD_FAMILIA,
      'COD_ARTESANA': instance.COD_ARTESANA,
      'COD_ORDEN_PRO': instance.COD_ORDEN_PRO,
      'CANTIDAD': instance.CANTIDAD,
      'CATEGORIA': instance.CATEGORIA,
      'TIPO_PESO': instance.TIPO_PESO,
      'FECHA_INGRESO': instance.FECHA_INGRESO,
      'UBICACION': instance.UBICACION,
      'PESO': instance.PESO,
      'IMAGEN': instance.IMAGEN,
      'ANCHO': instance.ANCHO,
      'ALTO': instance.ALTO,
    };
