import 'package:auto_route/auto_route.dart';
import 'package:wayllu_project/src/presentation/views/homeUser/user_carrito_screen.dart';
import 'package:wayllu_project/src/presentation/views/mainNavigationsRoles/admin_navigation.dart';
import 'package:wayllu_project/src/presentation/views/home_screen.dart';
import 'package:wayllu_project/src/presentation/views/login_example.dart';
import 'package:wayllu_project/src/presentation/views/mainNavigationsRoles/main_navigation.dart';
import 'package:wayllu_project/src/presentation/views/mainNavigationsRoles/user_navigation.dart';
import 'package:wayllu_project/src/presentation/views/usersAdmin/info_user_screen.dart';
import 'package:wayllu_project/src/presentation/views/usersAdmin/register_screen.dart';
import 'package:wayllu_project/src/presentation/views/usersAdmin/user_list_admin.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainNavigationRoute.page,
          initial: true,
          children: [
            RedirectRoute(path: '', redirectTo: 'login'),
            AutoRoute(
              path: 'login',
              page: LoginExampleRoute.page,
            ),
            AutoRoute(
              path: 'home',
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'user',
              page: UserNavigationRoute.page,
              children: [
                AutoRoute(
                  path: 'info',
                  page: InfoUserRoute.page,
                ),
                AutoRoute(
                  path: 'carrito',
                  page: CarritoRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'admin',
              page: AdminNavigationRoute.page,
              children: [
                AutoRoute(
                  path: 'users-list',
                  page: UsersListAdminRoute.page,
                ),
                AutoRoute(
                  path: 'register',
                  page: RegisterUserRoute.page,
                ),
              ],
            ),
          ],
        ),
      ];
}
