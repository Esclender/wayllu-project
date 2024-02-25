import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

abstract class ThemeApp {
  static ThemeData get light => ThemeData(
        fontFamily: 'Gotham',
        splashColor: Colors.transparent,
      );
}

abstract class SystemStyles {
  static SystemUiOverlayStyle get light => SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: bgPrimary,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
}
