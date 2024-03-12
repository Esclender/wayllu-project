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
    AdminNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AdminNavigationScreen(),
      );
    },
    AdminUsersNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AdminUsersNavigationScreen(),
      );
    },
    CarritoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CarritoScreen(),
      );
    },
    GraphicProductsRoute.name: (routeData) {
      final args = routeData.argsAs<GraphicProductsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GraphicProductsScreen(viewIndex: args.viewIndex),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(viewIndex: args.viewIndex),
      );
    },
    InfoUserRoute.name: (routeData) {
      final args = routeData.argsAs<InfoUserRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InfoUserScreen(
          viewIndex: args.viewIndex,
          isAdmin: args.isAdmin,
        ),
      );
    },
    LoginExampleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginExampleScreen(),
      );
    },
    MainNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainNavigationScreen(),
      );
    },
    RegisterUserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterUserScreen(),
      );
    },
    UserNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserNavigationScreen(),
      );
    },
    UsersListAdminRoute.name: (routeData) {
      final args = routeData.argsAs<UsersListAdminRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UsersListAdminScreen(viewIndex: args.viewIndex),
      );
    },
    CarritoScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CarritoScreen(),
      );
    },
  };
}

/// generated route for
/// [AdminNavigationScreen]
class AdminNavigationRoute extends PageRouteInfo<void> {
  const AdminNavigationRoute({List<PageRouteInfo>? children})
      : super(
          AdminNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AdminUsersNavigationScreen]
class AdminUsersNavigationRoute extends PageRouteInfo<void> {
  const AdminUsersNavigationRoute({List<PageRouteInfo>? children})
      : super(
          AdminUsersNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminUsersNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CarritoScreen]
class CarritoRoute extends PageRouteInfo<void> {
  const CarritoRoute({List<PageRouteInfo>? children})
      : super(
          CarritoRoute.name,
          initialChildren: children,
        );

  static const String name = 'CarritoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GraphicProductsScreen]
class GraphicProductsRoute extends PageRouteInfo<GraphicProductsRouteArgs> {
  GraphicProductsRoute({
    required int viewIndex,
    List<PageRouteInfo>? children,
  }) : super(
          GraphicProductsRoute.name,
          args: GraphicProductsRouteArgs(viewIndex: viewIndex),
          initialChildren: children,
        );

  static const String name = 'GraphicProductsRoute';

  static const PageInfo<GraphicProductsRouteArgs> page =
      PageInfo<GraphicProductsRouteArgs>(name);
}

class GraphicProductsRouteArgs {
  const GraphicProductsRouteArgs({required this.viewIndex});

  final int viewIndex;

  @override
  String toString() {
    return 'GraphicProductsRouteArgs{viewIndex: $viewIndex}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    required int viewIndex,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(viewIndex: viewIndex),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.viewIndex});

  final int viewIndex;

  @override
  String toString() {
    return 'HomeRouteArgs{viewIndex: $viewIndex}';
  }
}

/// generated route for
/// [InfoUserScreen]
class InfoUserRoute extends PageRouteInfo<InfoUserRouteArgs> {
  InfoUserRoute({
    required int viewIndex,
    bool isAdmin = false,
    List<PageRouteInfo>? children,
  }) : super(
          InfoUserRoute.name,
          args: InfoUserRouteArgs(
            viewIndex: viewIndex,
            isAdmin: isAdmin,
          ),
          initialChildren: children,
        );

  static const String name = 'InfoUserRoute';

  static const PageInfo<InfoUserRouteArgs> page =
      PageInfo<InfoUserRouteArgs>(name);
}

class InfoUserRouteArgs {
  const InfoUserRouteArgs({
    required this.viewIndex,
    this.isAdmin = false,
  });

  final int viewIndex;

  final bool isAdmin;

  @override
  String toString() {
    return 'InfoUserRouteArgs{viewIndex: $viewIndex, isAdmin: $isAdmin}';
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
/// [MainNavigationScreen]
class MainNavigationRoute extends PageRouteInfo<void> {
  const MainNavigationRoute({List<PageRouteInfo>? children})
      : super(
          MainNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterUserScreen]
class RegisterUserRoute extends PageRouteInfo<void> {
  const RegisterUserRoute({List<PageRouteInfo>? children})
      : super(
          RegisterUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterUserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserNavigationScreen]
class UserNavigationRoute extends PageRouteInfo<void> {
  const UserNavigationRoute({List<PageRouteInfo>? children})
      : super(
          UserNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsersListAdminScreen]
class UsersListAdminRoute extends PageRouteInfo<UsersListAdminRouteArgs> {
  UsersListAdminRoute({
    required int viewIndex,
    List<PageRouteInfo>? children,
  }) : super(
          UsersListAdminRoute.name,
          args: UsersListAdminRouteArgs(viewIndex: viewIndex),
          initialChildren: children,
        );

  static const String name = 'UsersListAdminRoute';

  static const PageInfo<UsersListAdminRouteArgs> page =
      PageInfo<UsersListAdminRouteArgs>(name);
}

class UsersListAdminRouteArgs {
  const UsersListAdminRouteArgs({required this.viewIndex});

  final int viewIndex;

  @override
  String toString() {
    return 'UsersListAdminRouteArgs{viewIndex: $viewIndex}';
  }
}

class CarritoScreenRoute extends PageRouteInfo<void> {
  const CarritoScreenRoute({List<PageRouteInfo>? children})
      : super(
          CarritoScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CarritoScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
