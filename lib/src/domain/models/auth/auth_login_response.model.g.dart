// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginResponse _$AuthLoginResponseFromJson(Map<String, dynamic> json) =>
    AuthLoginResponse(
      tokenAccesso: json['tokenAccesso'] as String,
      exitoso: json['exitoso'] as bool,
      ROL: json['ROL'] as String,
    );

Map<String, dynamic> _$AuthLoginResponseToJson(AuthLoginResponse instance) =>
    <String, dynamic>{
      'exitoso': instance.exitoso,
      'tokenAccesso': instance.tokenAccesso,
      'ROL': instance.ROL,
    };
