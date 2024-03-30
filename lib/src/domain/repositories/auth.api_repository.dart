import 'package:wayllu_project/src/domain/dtos/user_credentials_rep.dart';
import 'package:wayllu_project/src/domain/repositories/types/auth_types.dart';

abstract class AuthRepository {
  Future<AuthLoginHttpResponse> getAccessToken(UserCredentialDto credentials);
}
