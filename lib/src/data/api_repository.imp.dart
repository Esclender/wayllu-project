import 'package:logger/logger.dart';
import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';
import 'package:wayllu_project/src/data/remoteRespositories/auth/auth.repo.dart';
import 'package:wayllu_project/src/data/remoteRespositories/productos/productos.repo.dart';
import 'package:wayllu_project/src/data/repository_base.dart';
import 'package:wayllu_project/src/domain/dtos/usersCredentialsDto/user_credentials_rep.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/domain/models/venta/venta_repo.dart';
import 'package:wayllu_project/src/domain/repositories/artisans.api_repository.dart';
import 'package:wayllu_project/src/domain/repositories/auth.api_repository.dart';
import 'package:wayllu_project/src/domain/repositories/products.api_repository.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';
import 'package:wayllu_project/src/domain/repositories/types/auth_types.dart';
import 'package:wayllu_project/src/domain/repositories/types/products_types.dart';

class ArtisansApiRepositoryImpl extends BaseApiRepository
    implements ArtisansRepository {
  final ArtesansApiServices _apiServices;

  ArtisansApiRepositoryImpl(this._apiServices);

  //Se define una capara para obtener los datos desde api
  //Con el proposito de validaciones o otro manejo de datos
  @override
  Future<ArtesansListHttpResponse> getArtisans(
    int pagina,
    String nombre,
  ) async {
    final responseHttp = await getStateOf<ArtesansListHttpResponse>(
      request: () => _apiServices.getArtisans(pagina, nombre),
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

  @override
  Future<UserInfo?> getLoggedUserInfo() async {
    final responseHttp = await getStateOf<UserInfo?>(
      request: () => _apiServices.getUserLoggedInfo(),
    );

    return responseHttp.data;
  }
}

class ProductsApiRepositoryImpl extends BaseApiRepository
    implements ProductRepository {
  final ProductsApiServices _apiServices;

  ProductsApiRepositoryImpl(this._apiServices);

  //Se define una capara para obtener los datos desde api
  //Con el proposito de validaciones o otro manejo de datos
  @override
  Future<ProductsListHttpResponse> getProducts() async {
    final responseHttp = await getStateOf<ProductsListHttpResponse>(
      request: () => _apiServices.getProducts(),
    );

    return responseHttp.data;
  }

  @override
  Future<VentaInfo> newVenta(Map<String, dynamic> ventaData) async {
    final response = await getStateOf<VentaInfo>(
      request: () => _apiServices.newVenta(ventaData),
    );

    return response.data!;
  }
}
