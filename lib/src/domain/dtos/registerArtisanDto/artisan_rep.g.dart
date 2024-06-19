// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artisan_rep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtesanoDto _$ArtesanoDtoFromJson(Map<String, dynamic> json) => ArtesanoDto(
      NOMBRE_COMPLETO: json['NOMBRE_COMPLETO'] as String,
      DNI: json['DNI'] as int,
      COMUNIDAD: json['COMUNIDAD'] as String,
      CDG_COMUNIDAD: json['CDG_COMUNIDAD'] as int,
      CLAVE: json['CLAVE'] as String,
      CODIGO: json['CODIGO'] as int,
      URL_IMAGE: json['URL_IMAGE'] as String,
      ROL: json['ROL'] as String,
    );

Map<String, dynamic> _$ArtesanoDtoToJson(ArtesanoDto instance) =>
    <String, dynamic>{
      'NOMBRE_COMPLETO': instance.NOMBRE_COMPLETO,
      'DNI': instance.DNI,
      'COMUNIDAD': instance.COMUNIDAD,
      'CDG_COMUNIDAD': instance.CDG_COMUNIDAD,
      'CLAVE': instance.CLAVE,
      'CODIGO': instance.CODIGO,
      'URL_IMAGE': instance.URL_IMAGE,
      'ROL': instance.ROL,
    };
