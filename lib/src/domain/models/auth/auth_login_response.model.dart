// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'auth_login_response.model.g.dart';

@JsonSerializable()
class AuthLoginResponse {
  AuthLoginResponse({
    required this.tokenAccesso,
    required this.exitoso,
    required this.ROL,
  });

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseFromJson(json);

  bool exitoso;
  String tokenAccesso;
  String ROL;

  Map<String, dynamic> toJson() => _$AuthLoginResponseToJson(this);
}
