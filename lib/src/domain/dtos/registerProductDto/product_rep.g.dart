// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_rep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
      ANCHO: json['ANCHO'] as int,
      ALTO: json['ALTO'] as int,
      TIPO_PESO: json['TIPO_PESO'] as String,
      PESO: json['PESO'] as int,
      CATEGORIA: json['CATEGORIA'] as String,
      IMAGEN: json['IMAGEN'] as String,
      DESCRIPCION: json['DESCRIPCION'] as String,
      COD_FAMILIA: json['COD_FAMILIA'] as int,
      COD_ARTESANA: json['COD_ARTESANA'] as int,
      UBICACION: json['UBICACION'] as String,
      CANTIDAD: json['CANTIDAD'] as int,
      PRECIO: (json['PRECIO'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'ANCHO': instance.ANCHO,
      'ALTO': instance.ALTO,
      'TIPO_PESO': instance.TIPO_PESO,
      'PESO': instance.PESO,
      'CATEGORIA': instance.CATEGORIA,
      'IMAGEN': instance.IMAGEN,
      'DESCRIPCION': instance.DESCRIPCION,
      'COD_FAMILIA': instance.COD_FAMILIA,
      'COD_ARTESANA': instance.COD_ARTESANA,
      'UBICACION': instance.UBICACION,
      'CANTIDAD': instance.CANTIDAD,
      'PRECIO': instance.PRECIO,
    };
