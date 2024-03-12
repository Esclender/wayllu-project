import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/list_generator.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

@RoutePage()
class UsersListAdminScreen extends HookWidget {
  final int viewIndex;
  final double navbarHeight = 60;

  UsersListAdminScreen({
    required this.viewIndex,
  });

  final appRouter = getIt<AppRouter>();

  void _navigateRegisterUser() {
    appRouter.pushNamed('/admin/register');
  }

  final List<ColorfullItem> data = [
    ColorfullItem(
      url:
          'https://images.unsplash.com/profile-1446404465118-3a53b909cc82?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=3ef46b07bb19f68322d027cb8f9ac99f',
      nombre: 'Random 1',
      descriptions: [
        DescriptionItem(field: 'DNI', value: '45678932'),
        DescriptionItem(field: 'Comunidad', value: 'Grupo 1'),
        DescriptionItem(field: 'Tlf', value: '928590695'),
        DescriptionItem(field: 'Registrado', value: '23/05/2023'),
      ],
    ),
  ];

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
          _buildScrollableWidgets(
            [
              TopVector(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      text: 'Usuarios',
                      fontSize: 25.0,
                    ),
                    ColorfullItemsList(
                      listType: ListEnums.users,
                      dataToRender: data,
                      isScrollable: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildRegisterUserBtn(),
        ],
      ),
    );
  }

  Widget _buildScrollableWidgets(List<Widget> children) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            children,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterUserBtn() {
    return Container(
      margin: EdgeInsets.only(bottom: navbarHeight + 10, right: 10),
      child: InkWell(
        onTap: _navigateRegisterUser,
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
      ),
    );
  }
}
