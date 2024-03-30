import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wayllu_project/src/config/dio.interceptor.dart';
import 'package:wayllu_project/src/config/env.config.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';
import 'package:wayllu_project/src/data/remoteRespositories/auth/auth.repo.dart';

final getIt = GetIt.instance;

void initializeDependecies() {
  getIt.registerSingleton<AppRouter>(AppRouter());

  final dio = Dio();
  dio.options.baseUrl = EnvConfig.apiUrl;

  getIt.registerSingleton<AuthApiServices>(AuthApiServices(dio));
  getIt.registerSingleton<AuthApiRepositoryImpl>(
    AuthApiRepositoryImpl(getIt.get<AuthApiServices>()),
  );
}

void initializeEndpoints(String token) {
  final dio = Dio();
  dio.options.baseUrl = EnvConfig.apiUrl;
  dio.interceptors.add(DioInterceptor(token));
  getIt.registerSingleton<Dio>(dio);

  getIt.registerSingleton<ArtesansApiServices>(ArtesansApiServices(dio));
  getIt.registerSingleton<ArtisansApiRepositoryImpl>(
    ArtisansApiRepositoryImpl(getIt.get<ArtesansApiServices>()),
  );
}
