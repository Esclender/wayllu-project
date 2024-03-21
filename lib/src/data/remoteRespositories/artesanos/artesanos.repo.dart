import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wayllu_project/src/domain/models/user_info_model.dart';

part 'artesanos.repo.g.dart';

@RestApi(baseUrl: 'http://localhost:3001')
abstract class ArtesansApiServices {
  factory ArtesansApiServices(Dio dio, {String baseUrl}) = _ArtesansApiServices;

  @GET('/api/artesanos')
  Future<List<UserInfo>> getTasks();
}
