import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/presentation/cubit/users_list_cubit.dart';
import 'package:wayllu_project/src/presentation/widgets/list_generator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class CustomSearchWidget<T> extends StatefulWidget {
  final Future<void> Function(BuildContext context, String query)
      filterDataFunction;

  final double? width;
  final double? height;
  final bool? isHome;
  final String hint;

  const CustomSearchWidget({
    required this.filterDataFunction,
    this.hint = 'Buscar por Nombre',
    this.width,
    this.height,
    this.isHome,
  });

  @override
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final BuildContext c = context;
    widget.filterDataFunction(c, query);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersListCubit, List<CardTemplate>?>(
      builder: (context, filteredData) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: bottomNavBar,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [simpleShadow],
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Ionicons.search),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        (widget.width ?? 0.82),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextField(
                      onChanged: (q) {
                        _onSearchChanged(q);
                      },
                      decoration: InputDecoration(
                        fillColor: bottomNavBar,
                        border: InputBorder.none,
                        hintText: widget.hint,
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {},
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.isHome == null)
              Container()
            else
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: _buildSearchResults(filteredData ?? []),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults(List<CardTemplate> dataToRender) {
    if (dataToRender.isEmpty) {
      return const Center(child: Text('No se encontraron resultados'));
    }

    return CardTemplateItemsList(
      listType: ListEnums.users,
      dataToRender: dataToRender,
      isScrollable: false,
    );
  }
}
