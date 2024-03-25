import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';

final getIt = GetIt.instance;

void initializeDependecies() {
  getIt.registerSingleton<AppRouter>(AppRouter());

  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());
  getIt.registerSingleton<Dio>(dio);

  getIt.registerSingleton<ArtesansApiServices>(ArtesansApiServices(dio));

  getIt.registerSingleton<ArtisansApiRepositoryImpl>(
    ArtisansApiRepositoryImpl(getIt.get<ArtesansApiServices>()),
  );
}