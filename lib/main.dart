import 'package:flutter/material.dart';
import 'package:wayllu_project/src/config/theme/app_theme.dart';
import 'package:wayllu_project/src/presentation/views/auth/register_screen.dart';
import 'package:wayllu_project/src/presentation/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.light,
      home: AnnotatedRegion(
        value: SystemStyles.light,
        // child: const HomeScreen(null),
        child: const loginScreen(),
      ),
    );
  }
}
