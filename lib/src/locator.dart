import 'package:get_it/get_it.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';

final getIt = GetIt.instance;

void initializeDependecies() {
  getIt.registerSingleton<AppRouter>(AppRouter());
}
