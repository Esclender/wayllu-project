import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/data/api_repository.imp.dart';
import 'package:wayllu_project/src/data/remoteRespositories/artesanos/artesanos.repo.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/users_list_cubit.dart';
import 'package:wayllu_project/src/presentation/views/home_screen.dart';
import 'package:wayllu_project/src/presentation/widgets/bar_search.dart';
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
  // Controlador para el campo de búsqueda

  void _navigateRegisterUser() {
    appRouter.pushNamed('/admin/register');
  }

  @override
  Widget build(BuildContext contex) {
    final TextEditingController searchController = useTextEditingController();
    final ValueNotifier<List<CardTemplate>> searchResults = useState([]);

    final usersListCubit = contex.watch<UsersListCubit>();
    useEffect(
      () {
        usersListCubit.getUserLists();

        return () {};
      },
      const [],
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _buildScrollableLayer(state, contex);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableLayer(
      List<CardTemplate> usersToRender, BuildContext context) {
    final usersListCubit = UsersListCubit(
        ArtisansApiRepositoryImpl(getIt.get<ArtesansApiServices>()));
    final searchController = TextEditingController();
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
                  SizedBox(height: 8,),
                  CustomSearchWidget(allData: usersToRender,),

                  /*CardTemplateItemsList(
                    listType: ListEnums.users,
                    dataToRender: usersToRender,
                    isScrollable: false,
                  ),*/
                ],
              ),
            ),
          ],
        ),
        _buildRegisterUserBtn(),
      ],
    );
  }

/*
Widget _buildSearchBar(BuildContext context, UsersListCubit usersListCubit, List<CardTemplate> usersToRender) {
  return TextButton(
    onPressed: () {
      showSearch(
        context: context,
        delegate: CustomSearchDelegate(usersListCubit: usersListCubit, usersToRender: usersToRender),
      );
    },
    child: Container(
      // Aquí puedes agregar estilos y decoraciones según sea necesario
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8), // Espacio entre el ícono y el texto
          Text('Buscar'),
        ],
      ),
    ),
  );
}
*/
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
      margin: EdgeInsets.only(bottom: navbarHeight + 5, right: 10),
      child: InkWell(
        onTap: _navigateRegisterUser,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: thirdColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [strongShadow]),
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
