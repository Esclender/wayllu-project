// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_rep.g.dart';

@JsonSerializable()
class UserCredentialDto extends Equatable {
  const UserCredentialDto({
    required this.DNI,
    required this.CLAVE,
  });

  final int DNI;
  final String CLAVE;

  @override
  List<Object?> get props => [
        DNI,
        CLAVE,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'DNI': DNI,
      'CLAVE': CLAVE,
    };
  }

  factory UserCredentialDto.fromMap(Map<String, dynamic> map) {
    return UserCredentialDto(
      DNI: map['DNI'] as int,
      CLAVE: map['CLAVE'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCredentialDto.fromJson(String source) =>
      UserCredentialDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
