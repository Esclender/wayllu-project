import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/users_list_cubit.dart';
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

  @override
  Widget build(BuildContext contex) {
    final usersListCubit = contex.watch<UsersListCubit>();

    useEffect(
      () {
        usersListCubit.getUserLists();

        return () {};
      },
      const [],
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      body: BlocBuilder<UsersListCubit, List<ColorfullItem>?>(
        builder: (_, state) {
          if (state == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return _buildScrollableLayer(state);
        },
      ),
    );
  }

  Widget _buildScrollableLayer(List<ColorfullItem> usersToRender) {
    return Stack(
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
                    dataToRender: usersToRender,
                    isScrollable: false,
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildRegisterUserBtn(),
      ],
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
