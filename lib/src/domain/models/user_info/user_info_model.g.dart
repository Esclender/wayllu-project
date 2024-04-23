// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      DNI: json['DNI'] as int,
      NOMBRE_COMPLETO: json['NOMBRE_COMPLETO'] as String,
      COMUNIDAD: json['COMUNIDAD'] as String?,
      CLAVE: json['CLAVE'] as String,
      FECHA_REGISTRO: json['FECHA_REGISTRO'] as String?,
      URL_IMAGE: json['URL_IMAGE'] as String?,
      TELEFONO: json['TELEFONO'] as String?,
      EMAIL: json['EMAIL'] as String?,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'DNI': instance.DNI,
      'NOMBRE_COMPLETO': instance.NOMBRE_COMPLETO,
      'CLAVE': instance.CLAVE,
      'FECHA_REGISTRO': instance.FECHA_REGISTRO,
      'COMUNIDAD': instance.COMUNIDAD,
      'URL_IMAGE': instance.URL_IMAGE,
      'TELEFONO': instance.TELEFONO,
      'EMAIL': instance.EMAIL,
      'isAdmin': instance.isAdmin,
    };
