import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:wayllu_project/src/config/dio.interceptor.dart';
import 'package:wayllu_project/src/config/env.config.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';
import 'package:wayllu_project/src/data/remoteRespositories/auth/auth.repo.dart';
import 'package:wayllu_project/src/data/remoteRespositories/productos/productos.repo.dart';

final getIt = GetIt.instance;

final getItAppRouter = GetIt.asNewInstance();

void initializeDependecies() {
  getItAppRouter.registerSingleton<AppRouter>(AppRouter());

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

  // Register Dio singleton
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerSingleton<Dio>(dio);
  } else {
    getIt.unregister<Dio>();
    getIt.registerSingleton<Dio>(dio);
  }

  // Register ArtesansApiServices singleton
  if (!getIt.isRegistered<ArtesansApiServices>()) {
    getIt.registerSingleton<ArtesansApiServices>(ArtesansApiServices(dio));
  } else {
    getIt.unregister<ArtesansApiServices>();
    getIt.registerSingleton<ArtesansApiServices>(ArtesansApiServices(dio));
  }

  // Register ArtisansApiRepositoryImpl singleton
  if (!getIt.isRegistered<ArtisansApiRepositoryImpl>()) {
    getIt.registerSingleton<ArtisansApiRepositoryImpl>(
      ArtisansApiRepositoryImpl(getIt.get<ArtesansApiServices>()),
    );
  } else {
    getIt.unregister<ArtisansApiRepositoryImpl>();
    getIt.registerSingleton<ArtisansApiRepositoryImpl>(
      ArtisansApiRepositoryImpl(getIt.get<ArtesansApiServices>()),
    );
  }

  // Register ProductsApiServices singleton
  if (!getIt.isRegistered<ProductsApiServices>()) {
    getIt.registerSingleton<ProductsApiServices>(ProductsApiServices(dio));
  } else {
    getIt.unregister<ProductsApiServices>();
    getIt.registerSingleton<ProductsApiServices>(ProductsApiServices(dio));
  }

  // Register ProductsApiRepositoryImpl singleton
  if (!getIt.isRegistered<ProductsApiRepositoryImpl>()) {
    getIt.registerSingleton<ProductsApiRepositoryImpl>(
      ProductsApiRepositoryImpl(getIt.get<ProductsApiServices>()),
    );
  } else {
    getIt.unregister<ProductsApiRepositoryImpl>();
    getIt.registerSingleton<ProductsApiRepositoryImpl>(
      ProductsApiRepositoryImpl(getIt.get<ProductsApiServices>()),
    );
  }

  // Unregister and register AuthApiServices
  if (getIt.isRegistered<AuthApiServices>()) {
    getIt.unregister<AuthApiServices>();
  }
  getIt.registerSingleton<AuthApiServices>(AuthApiServices(dio));

  // Unregister and register AuthApiRepositoryImpl
  if (getIt.isRegistered<AuthApiRepositoryImpl>()) {
    getIt.unregister<AuthApiRepositoryImpl>();
  }
  getIt.registerSingleton<AuthApiRepositoryImpl>(
    AuthApiRepositoryImpl(getIt.get<AuthApiServices>()),
  );
}

void unregisterDependenciesAndEnpoints() {
  SystemNavigator.pop();
}
