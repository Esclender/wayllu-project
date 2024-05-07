import 'package:wayllu_project/src/domain/dtos/usersCredentialsDto/user_credentials_rep.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/auth_types.dart';

abstract class AuthRepository {
  Future<AuthLoginHttpResponse> getAccessToken(UserCredentialDto credentials);
  Future<void> updateUserInfo(Map<String, dynamic> info);
  Future<UserInfo?> getLoggedUserInfo();
}
