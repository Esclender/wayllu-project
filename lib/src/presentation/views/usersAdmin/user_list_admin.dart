import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/list_generator.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class UsersListAdminScreen extends HookWidget {
  final int viewIndex = 2;

  final double navbarHeight = 60;

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              TopVector(),
              Expanded(
                child: ColorfullItemsList(
                  listType: ListEnums.users,
                ),
              ),
            ],
          ),
          _buildRegisterUserBtn(),
        ],
      ),
    );
  }

  Widget _buildRegisterUserBtn() {
    return Container(
      margin: EdgeInsets.only(bottom: navbarHeight + 10, right: 10),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          gradient: gradientOrange,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Ionicons.person_add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
