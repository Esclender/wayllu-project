// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials_rep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialDto _$UserCredentialDtoFromJson(Map<String, dynamic> json) =>
    UserCredentialDto(
      DNI: json['DNI'] as int,
      CLAVE: json['CLAVE'] as String,
    );

Map<String, dynamic> _$UserCredentialDtoToJson(UserCredentialDto instance) =>
    <String, dynamic>{
      'DNI': instance.DNI,
      'CLAVE': instance.CLAVE,
    };
