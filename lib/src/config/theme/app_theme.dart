import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

abstract class ThemeApp {
  static ThemeData get light => ThemeData(
        fontFamily: 'Gotham',
        splashColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemStyles.light,
        ),
      );
}

abstract class SystemStyles {
  static SystemUiOverlayStyle get light => SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: bgPrimary,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  static SystemUiOverlayStyle get login => SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: loginBottom,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
}
