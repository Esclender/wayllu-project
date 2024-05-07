import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:wayllu_project/main.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/domain/dtos/usersCredentialsDto/user_credentials_rep.dart';
import 'package:wayllu_project/src/domain/enums/user_roles.dart';
import 'package:wayllu_project/src/domain/models/auth/auth_login_response.model.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';

class UserLoggedCubit extends Cubit<UserRoles> {
  final AuthApiRepositoryImpl _authRepository;

  UserLoggedCubit(this._authRepository) : super(UserRoles.artesano);

  void _setAdminRole() => emit(UserRoles.admin);

  Future<String?> getAccessTokenAndSetRol(UserCredentialDto credentials) async {
    final AuthLoginResponse? response =
        await _authRepository.getAccessToken(credentials);

    if (!(response?.exitoso ?? false)) throw Exception('Sin Respuesta!');

    if (response!.ROL == 'ADMIN') {
      _setAdminRole();
    }

    return response.tokenAccesso;
  }
}

class UserLoggedInfoCubit extends Cubit<UserInfo?> {
  final AuthApiRepositoryImpl _authRepository;

  UserLoggedInfoCubit(this._authRepository) : super(null);

  Future<void> setUserInfo() async {
    final UserInfo? response = await _authRepository.getLoggedUserInfo();
    Logger().i(response);
    emit(response);
  }

  Future<void> updateUserInfo(Map<String, dynamic> dataToUpdate) async {
    final authImp = locator.get<AuthApiRepositoryImpl>();
    await authImp.updateUserInfo(dataToUpdate);
    await setUserInfo();
  }
}
