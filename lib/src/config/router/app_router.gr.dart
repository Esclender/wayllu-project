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
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InfoUserScreen(),
      );
    },
    LoginExampleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginExampleScreen(),
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
class InfoUserRoute extends PageRouteInfo<void> {
  const InfoUserRoute({List<PageRouteInfo>? children})
      : super(
          InfoUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'InfoUserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
