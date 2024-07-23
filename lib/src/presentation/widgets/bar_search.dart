import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
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
  final bool isHome;
  final String hint;
  final ValueNotifier<bool>? isSearching;

  const CustomSearchWidget({
    required this.filterDataFunction,
    this.isSearching,
    this.hint = 'Buscar por Nombre',
    this.width,
    this.height,
    required this.isHome,
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

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
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
                    child: Icon(Ionicons.search, color: Colors.grey,),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        (widget.width ?? 0.82),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextField(
                      controller: _searchController,
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
                                onPressed: _clearSearch,
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.isHome)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: _buildSearchResultsHome(filteredData ?? []),
              )
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

  Widget _buildSearchResultsHome(List<CardTemplate> dataToRender) {
    return Container();
  }

  Widget _buildSearchResults(List<CardTemplate> dataToRender) {
    const double registerUserBtnHeight = 60.0;

    if (dataToRender.isEmpty) {
      return ListView.separated(
        separatorBuilder: (context, index) => const Gap(8),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext c, int ind) {
          return _buildItemContainer();
        },
      );
    }

    if (widget.isSearching!.value) {
      return Column(
        children: [
          CardTemplateItemsList(
            listType: ListEnums.users,
            dataToRender: dataToRender,
            isScrollable: false,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: registerUserBtnHeight + 20,
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: registerUserBtnHeight - 20),
      child: CardTemplateItemsList(
        listType: ListEnums.users,
        dataToRender: dataToRender,
        isScrollable: false,
      ),
    );
  }

  Widget _buildItemContainer() {
    final BoxDecoration decoration = BoxDecoration(
      color: bottomNavBar,
      boxShadow: [
        simpleShadow,
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    );

    final double additionalPadding = 10;

    return Stack(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: decoration,
              child: _buildShimmerEffect(context),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 5 + additionalPadding),
              decoration: decoration,
              child: _buildShimmerEffect2(context),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 95,
                top: 5 + additionalPadding,
              ),
              decoration: decoration,
              child: _buildShimmerEffectText(context),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 95,
                top: 20 + additionalPadding,
              ),
              decoration: decoration,
              child: _buildShimmerEffectText(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect2(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
        width: 55,
        height: 55,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffectText(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
        width: 100,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
