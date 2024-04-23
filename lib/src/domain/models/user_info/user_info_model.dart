// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo({
    required this.DNI,
    required this.NOMBRE_COMPLETO,
    required this.COMUNIDAD,
    required this.CLAVE,
    required this.FECHA_REGISTRO,
    this.URL_IMAGE,
    this.TELEFONO,
    this.EMAIL,
    this.isAdmin = false,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  int DNI;
  String NOMBRE_COMPLETO;
  String CLAVE;
  String? FECHA_REGISTRO;
  String? COMUNIDAD;
  String? URL_IMAGE;
  String? TELEFONO;
  String? EMAIL;
  bool isAdmin;

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  CardTemplate toCardTemplate() {
    return CardTemplate(
      url: URL_IMAGE ?? '',
      nombre: NOMBRE_COMPLETO,
      descriptions: [
        DescriptionItem(field: 'DNI', value: DNI.toString()),
        DescriptionItem(field: 'Comunidad', value: COMUNIDAD ?? ''),
        DescriptionItem(field: 'Tlf', value: TELEFONO ?? ''),
        DescriptionItem(field: 'Registrado', value: formattingDate()),
      ],
    );
  }

  PersonalInfo get userInfo => PersonalInfo(
        DNI: DNI,
        NOMBRE_COMPLETO: NOMBRE_COMPLETO,
        COMUNIDAD: COMUNIDAD ?? '',
        CLAVE: CLAVE,
      );

  ContactInfo get userContactInfo => ContactInfo(
        TELEFONO: TELEFONO,
        EMAIL: EMAIL,
      );

  String formattingDate() {
    final DateTime dateTime = FECHA_REGISTRO != null
        ? DateTime.parse(FECHA_REGISTRO ?? '')
        : DateTime.now();

    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
}

abstract class InfoBase {
  List<List> get entries => [];
}

class PersonalInfo extends InfoBase {
  int DNI;
  String NOMBRE_COMPLETO;
  String COMUNIDAD;
  String CLAVE;
  String? URL_IMAGE;
  bool isAdmin;

  PersonalInfo({
    required this.DNI,
    required this.NOMBRE_COMPLETO,
    required this.COMUNIDAD,
    required this.CLAVE,
    this.isAdmin = false,
    this.URL_IMAGE,
  });

  @override
  List<List> get entries => [
        ['DNI', DNI],
        ['Nombre', NOMBRE_COMPLETO],
        ['Comunidad', COMUNIDAD],
        ['Clave', CLAVE],
      ];
}

class ContactInfo extends InfoBase {
  String? TELEFONO;
  String? EMAIL;

  ContactInfo({
    this.TELEFONO,
    this.EMAIL,
  });

  @override
  List<List> get entries => [
        ['Telefono', TELEFONO],
        ['Email', EMAIL],
      ];
}
