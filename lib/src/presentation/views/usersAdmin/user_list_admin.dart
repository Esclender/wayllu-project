import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';

@RoutePage()
class UsersListAdminScreen extends HookWidget {
  final int viewIndex = 2;

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      body: Column(
        children: [
          TopVector(),
        ],
      ),
    );
  }
}
