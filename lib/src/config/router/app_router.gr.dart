// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(),
      );
    },
    InfoUserRoute.name: (routeData) {
      final args = routeData.argsAs<InfoUserRouteArgs>(
          orElse: () => const InfoUserRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InfoUserScreen(isAdmin: args.isAdmin),
      );
    },
    LoginExampleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginExampleScreen(),
      );
    },
    UsersListAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UsersListAdminScreen(),
      );
    },
  };
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InfoUserScreen]
class InfoUserRoute extends PageRouteInfo<InfoUserRouteArgs> {
  InfoUserRoute({
    bool isAdmin = false,
    List<PageRouteInfo>? children,
  }) : super(
          InfoUserRoute.name,
          args: InfoUserRouteArgs(isAdmin: isAdmin),
          initialChildren: children,
        );

  static const String name = 'InfoUserRoute';

  static const PageInfo<InfoUserRouteArgs> page =
      PageInfo<InfoUserRouteArgs>(name);
}

class InfoUserRouteArgs {
  const InfoUserRouteArgs({this.isAdmin = false});

  final bool isAdmin;

  @override
  String toString() {
    return 'InfoUserRouteArgs{isAdmin: $isAdmin}';
  }
}

/// generated route for
/// [LoginExampleScreen]
class LoginExampleRoute extends PageRouteInfo<void> {
  const LoginExampleRoute({List<PageRouteInfo>? children})
      : super(
          LoginExampleRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginExampleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsersListAdminScreen]
class UsersListAdminRoute extends PageRouteInfo<void> {
  const UsersListAdminRoute({List<PageRouteInfo>? children})
      : super(
          UsersListAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersListAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
