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
import 'package:wayllu_project/src/domain/repositories/types/ventas_types.dart';

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

  @override
  Future<void> registerArtisian(
    Map<String, dynamic> userInfo,
  ) async {
    await _apiServices.newArtisian(userInfo);
  }

  @override
  Future<ArtesansListHttpResponse?> getAllArtisansWithNoPage() async {
    final responseHttp = await getStateOf<ArtesansListHttpResponse>(
      request: () => _apiServices.getAllArtisansWithNoPage(),
    );

    return responseHttp.data;
  }

  @override
  Future<UserInfo?> getUniqueArtisan(Map<String, dynamic> filtro) async {
    final responseHttp = await getStateOf<UserInfo?>(
      request: () => _apiServices.getUniqueArtisian(filtro),
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
    final responseHttp = await getStateOf<AuthLoginHttpResponse>(
      request: () => _apiServices.getAccessToken(credentials),
    );

    return responseHttp.data;
  }

  @override
  Future<void> updateUserInfo(
    Map<String, dynamic> infoToUpdate,
  ) async {
    await _apiServices.updateUserInfo(infoToUpdate);
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
  //Con el proposito de validaciones u otro manejo de datos
  @override
  Future<ProductsListHttpResponse> getProducts({
    String? codigoProducto,
    int pagina = 1,
  }) async {
    final responseHttp = await getStateOf<ProductsListHttpResponse>(
      request: () => _apiServices.getProducts(codigoProducto, pagina),
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

  @override
  Future<VentasListHttpResponse> getVentas() async {
    final responseHttp = await getStateOf<VentasListHttpResponse>(
      request: () => _apiServices.getVentas(),
    );

    return responseHttp.data;
  }

  Future<VentasListHttpResponse> getVentasByYearAndMonth(
    String year,
    String mes,
  ) async {
    final responseHttp = await getStateOf<VentasListHttpResponse>(
      request: () => _apiServices.getVentasByYearAndMonth(year, mes),
    );

    return responseHttp.data;
  }

  @override
  Future<void> newProduct(Map<String, dynamic> productInfo) async {
    await getStateOf<void>(
      request: () => _apiServices.newProducto(productInfo),
    );
  }

  @override
  Future<void> updateProduct(Map<String, dynamic> productInfo) async {
    await getStateOf<void>(
      request: () => _apiServices.updateProducto(productInfo),
    );
  }
}
