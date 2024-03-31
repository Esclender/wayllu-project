import 'package:logger/logger.dart';
import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';
import 'package:wayllu_project/src/data/remoteRespositories/auth/auth.repo.dart';
import 'package:wayllu_project/src/data/repository_base.dart';
import 'package:wayllu_project/src/domain/dtos/user_credentials_rep.dart';
import 'package:wayllu_project/src/domain/repositories/artisans.api_repository.dart';
import 'package:wayllu_project/src/domain/repositories/auth.api_repository.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';
import 'package:wayllu_project/src/domain/repositories/types/auth_types.dart';

class ArtisansApiRepositoryImpl extends BaseApiRepository
    implements ArtisansRepository {
  final ArtesansApiServices _apiServices;

  ArtisansApiRepositoryImpl(this._apiServices);

  //Se define una capara para obtener los datos desde api
  //Con el proposito de validaciones o otro manejo de datos
  @override
  Future<ArtesansListHttpResponse> getArtisans() async {
    final responseHttp = await getStateOf<ArtesansListHttpResponse>(
      request: () => _apiServices.getArtisans(),
    );

    return responseHttp.data;
  }
}

class AuthApiRepositoryImpl extends BaseApiRepository
    implements AuthRepository {
  final AuthApiServices _apiServices;

  AuthApiRepositoryImpl(this._apiServices);

  @override
  Future<AuthLoginHttpResponse> getAccessToken(
    UserCredentialDto credentials,
  ) async {
    Logger().i(credentials);
    final responseHttp = await getStateOf<AuthLoginHttpResponse>(
      request: () => _apiServices.getAccessToken(credentials),
    );

    return responseHttp.data;
  }
}
