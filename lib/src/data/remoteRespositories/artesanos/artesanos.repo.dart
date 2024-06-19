import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

part 'artesanos.repo.g.dart';

@RestApi(baseUrl: '/api/artesanos')
abstract class ArtesansApiServices {
  factory ArtesansApiServices(Dio dio, {String baseUrl}) = _ArtesansApiServices;

  //Aqui definimos todos nuestros endpoints
  //estos endpoints seran los que se conecten con la api
  //Aqui definimos todos nuestros endpoints
  //estos endpoints seran los que se conecten con la api
  @GET('/')
  Future<HttpResponse<ArtesansListHttpResponse>> getArtisans(
    @Query('pagina') int pagina,
    @Query('nombre') String nombre,
  );


  @POST('/registro')
  Future<HttpResponse<void>> registerArtisan(
    @Body() Map<String, dynamic> artisanData,
  );
}
