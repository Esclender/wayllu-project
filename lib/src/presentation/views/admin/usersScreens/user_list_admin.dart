import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/users_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/bar_search.dart';
import 'package:wayllu_project/src/presentation/widgets/bottom_navbar.dart';
import 'package:wayllu_project/src/presentation/widgets/gradient_widgets.dart';
import 'package:wayllu_project/src/presentation/widgets/top_vector.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';
import 'package:wayllu_project/src/utils/extensions/scroll_controller_extension.dart';

@RoutePage()
class UsersListAdminScreen extends HookWidget {
  final int viewIndex;
  final double navbarHeight = 60;

  UsersListAdminScreen({
    required this.viewIndex,
  });

  final appRouter = getIt<AppRouter>();
  // Controlador para el campo de búsqueda

  void _navigateRegisterUser() {
    appRouter.pushNamed('/admin/register');
  }

  Future<void> getUsersFiltered(BuildContext context, String query) async {
    await context.read<UsersListCubit>().getUserLists(nombre: query);
  }

  @override
  Widget build(BuildContext contex) {
    final usersListCubit = contex.watch<UsersListCubit>();
    final scrollController = useScrollController();
    final isSearchingProducts = useState(false);

    final pagina = useState(1);

    useEffect(
      () {
        usersListCubit.getUserLists();

        scrollController.onScrollEndsListener(() {
          isSearchingProducts.value = true;

          pagina.value++;
          usersListCubit.getUserLists(pagina: pagina.value);

          Timer(const Duration(seconds: 3), () {
            isSearchingProducts.value = false;
          });
        });

        return scrollController.dispose;
      },
      [],
    );

    return Scaffold(
      backgroundColor: bgPrimary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomNavBar(
        viewSelected: viewIndex,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<UsersListCubit, List<CardTemplate>?>(
              builder: (_, state) {
                if (state == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _buildScrollableLayer(
                    state,
                    contex,
                    scrollController,
                    isSearchingProducts,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableLayer(
    List<CardTemplate> usersToRender,
    BuildContext context,
    ScrollController controller,
    ValueNotifier<bool> isSearching,
  ) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _buildScrollableWidgets(
          [
            TopVector(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    text: 'Usuarios',
                    fontSize: 25.0,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomSearchWidget(
                    isHome: false,
                    filterDataFunction: getUsersFiltered,
                    isSearching: isSearching,
                  ),
                ],
              ),
            ),
          ],
          controller,
        ),
        _buildRegisterUserBtn(),
      ],
    );
  }

  Widget _buildScrollableWidgets(
    List<Widget> children,
    ScrollController controller,
  ) {
    return CustomScrollView(
      controller: controller,
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
      margin: EdgeInsets.only(bottom: navbarHeight + 5, right: 10),
      child: InkWell(
        onTap: _navigateRegisterUser,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: thirdColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [strongShadow],
          ),
          child: const Icon(
            Ionicons.person_add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
