import 'package:auto_route/auto_route.dart';
import 'package:wayllu_project/src/presentation/views/admin/graphs/graph_screen.dart';
import 'package:wayllu_project/src/presentation/views/admin/usersScreens/admin_users_navigation.dart';
import 'package:wayllu_project/src/presentation/views/admin/usersScreens/register_screen.dart';
import 'package:wayllu_project/src/presentation/views/admin/usersScreens/user_list_admin.dart';
import 'package:wayllu_project/src/presentation/views/home_screen.dart';
import 'package:wayllu_project/src/presentation/views/login_screen.dart';
import 'package:wayllu_project/src/presentation/views/mainNavigationsRoles/admin_navigation.dart';
import 'package:wayllu_project/src/presentation/views/mainNavigationsRoles/main_navigation.dart';
import 'package:wayllu_project/src/presentation/views/mainNavigationsRoles/user_navigation.dart';
import 'package:wayllu_project/src/presentation/views/user/home/recibo_screen.dart';
import 'package:wayllu_project/src/presentation/views/user/home/user_carrito_screen.dart';
import 'package:wayllu_project/src/presentation/widgets/info_user_screen.dart';

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
              path: 'graphs',
              page: GraphicProductsRoute.page,
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
                AutoRoute(
                  path: 'recibo',
                  page: ReciboRoute.page,
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
                AutoRoute(
                  path: 'info',
                  page: InfoUserRoute.page,
                ),
              
              ],
            ),
          ],
        ),
      ];
}
