import 'package:flutter/material.dart';
import 'package:wayllu_project/src/domain/enums/user_roles.dart';

class OptionsIcons {
  IconData icon;
  List<OptionsIconsRoutes> routes;

  OptionsIcons({
    required this.icon,
    required this.routes,
  });
}

class OptionsIconsRoutes {
  String route;
  UserRoles rol;

  OptionsIconsRoutes({
    required this.route,
    required this.rol,
  });
}
