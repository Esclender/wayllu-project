import 'package:equatable/equatable.dart';

class UserCredentialDto extends Equatable {
  final String dni;
  final String clave;

  const UserCredentialDto({
    required this.dni,
    required this.clave,
  });

  @override
  List<Object?> get props => [
        dni,
        clave,
      ];
}
