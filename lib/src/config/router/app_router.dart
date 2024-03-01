import 'package:auto_route/auto_route.dart';
import 'package:wayllu_project/src/presentation/views/auth/register_user_screen.dart';
import 'package:wayllu_project/src/presentation/views/home_screen.dart';
import 'package:wayllu_project/src/presentation/views/info_user_screen.dart';
import 'package:wayllu_project/src/presentation/views/login_example.dart';
import 'package:wayllu_project/src/presentation/views/usersAdmin/user_list_admin.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: LoginExampleRoute.page, initial: true),
        AutoRoute(path: '/home', page: HomeRoute.page),
        AutoRoute(path: '/info-user', page: InfoUserRoute.page),
        AutoRoute(path: '/admin/register-user', page: UserRegisterRoute.page),
        AutoRoute(path: '/admin/user-lists', page: UsersListAdminRoute.page),
      ];
}

final appRouter = AppRouter();
