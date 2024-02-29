import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayllu_project/src/domain/dtos/user_credentials_rep.dart';

//States
enum UserRoles { admin, artesano }

class UserLoggedCubit extends Cubit<UserRoles> {
  UserLoggedCubit() : super(UserRoles.artesano);

  bool isAdmin(UserCredentialDto credentials) {
    //Lookup the credentials in db

    if (credentials.dni == 'admin') {
      _setAdminRole();
    }

    return credentials.dni == 'admin';
  }

  void _setAdminRole() => emit(UserRoles.admin);
}
