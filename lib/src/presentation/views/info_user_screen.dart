import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class InfoUserScreen extends HookWidget {
  const InfoUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: bgPrimary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text('Info User'),
        ),
      ),
      floatingActionButton: BottomNavBar(),
    );
  }
}
