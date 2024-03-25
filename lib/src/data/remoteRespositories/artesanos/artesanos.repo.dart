import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/domain/repositories/types/artesans_types.dart';

part 'artesanos.repo.g.dart';

@RestApi(baseUrl: 'https://23qnp6pm-3001.brs.devtunnels.ms')
abstract class ArtesansApiServices {
  factory ArtesansApiServices(Dio dio, {String baseUrl}) = _ArtesansApiServices;

  //Aqui definimos todos nuestros endpoints
  //estos endpoints seran los que se conecten con la api
  @GET('/api/artesanos')
  Future<HttpResponse<ArtesansListHttpResponse>> getArtisans();
}