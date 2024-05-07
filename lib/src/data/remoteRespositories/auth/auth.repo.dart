import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wayllu_project/src/domain/dtos/usersCredentialsDto/user_credentials_rep.dart';
import 'package:wayllu_project/src/domain/models/auth/auth_login_response.model.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/auth_types.dart';

part 'auth.repo.g.dart';

@RestApi(baseUrl: '/api/auth')
abstract class AuthApiServices {
  factory AuthApiServices(Dio dio, {String baseUrl}) = _AuthApiServices;

  @POST('/login')
  Future<HttpResponse<AuthLoginHttpResponse>> getAccessToken(
    @Body() UserCredentialDto credentials,
  );

  @PUT('/update')
  Future<HttpResponse<void>> updateUserInfo(
    @Body() Map<String, dynamic> info,
  );

  @GET('/login/info')
  Future<HttpResponse<UserInfo?>> getUserLoggedInfo();
}
