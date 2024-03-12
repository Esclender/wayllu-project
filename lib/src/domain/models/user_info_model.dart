class UserInfo {
  PersonalInfo userInfo;
  ContactInfo userContactInfo;

  UserInfo({
    required this.userInfo,
    required this.userContactInfo,
  });
}

abstract class InfoBase {
  List<List> get entries => [];
}

class PersonalInfo extends InfoBase {
  String dni;
  String nombre;
  String comunidad;
  String clave;
  String? urlProfile;
  bool isAdmin;

  PersonalInfo({
    required this.dni,
    required this.nombre,
    required this.comunidad,
    required this.clave,
    required this.isAdmin,
    this.urlProfile,
  });

  @override
  List<List> get entries => [
        ['DNI', dni],
        ['Nombre', nombre],
        ['Comunidad', comunidad],
        ['Clave', clave],
      ];
}

class ContactInfo extends InfoBase {
  String telefono;
  String? email;

  ContactInfo({
    required this.telefono,
    this.email,
  });

  @override
  List<List> get entries => [
        ['Telefono', telefono],
        ['Email', email],
      ];
}
