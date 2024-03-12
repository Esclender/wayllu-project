import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class ColorfullItemsList extends HookWidget {
  final ListEnums listType;
  final List<ColorfullItem> dataToRender;
  final bool isScrollable;

  //Dependencies Injection
  final appRouter = getIt<AppRouter>();

  ColorfullItemsList({
    required this.listType,
    required this.dataToRender,
    this.isScrollable = true,
  });

  final double navBarHeight = 60.0;
  final double registerUserBtnHeight = 60.0;

  //[gradient, color]
  final List<List> gradients = [
    [gradientMain, mainColor],
    [gradientSecondary, secondaryColor],
    [gradientThird, thirdColor],
    [gradientFourth, fourthColor],
  ];

  void _navigateToEditUser() {
    appRouter.navigate(InfoUserRoute(viewIndex: 2));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Gap(35),
      physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dataToRender.length,
      itemBuilder: (BuildContext c, int ind) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: ind == dataToRender.length - 1
                ? listType == ListEnums.users
                    ? navBarHeight + (registerUserBtnHeight * 2)
                    : navBarHeight + 10
                : 0.0,
          ),
          child: _buildItemContainer(
            itemData: dataToRender[0],
          ),
        );
      },
    );
  }

  Widget _buildItemContainer({
    required ColorfullItem itemData,
  }) {
    final BoxDecoration decoration = BoxDecoration(
      boxShadow: [
        simpleShadow,
      ],
      gradient: gradients[itemData.gradient][0] as Gradient,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
    );

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: decoration,
              child: _listTile(
                leading: _buildImageAvatar(itemData.url),
                title: Text(itemData.nombre),
                fields: itemData.descriptions,
              ),
            ),
            _itemMarker(
              gradients[itemData.gradient][1] as Color,
            ),
          ],
        ),
        if (listType == ListEnums.users) _itemEdit() else Container(),
      ],
    );
  }

  Widget _buildImageAvatar(String url) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _itemEdit() {
    return InkWell(
      onTap: _navigateToEditUser,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: gradientOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Ionicons.pencil,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _itemMarker(
    Color colorMarker,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 5.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: colorMarker,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
    );
  }

  Widget _listTile({
    required Widget leading,
    required Widget title,
    required List<DescriptionItem> fields,
  }) {
    return Row(
      children: [
        leading,
        const Gap(24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            ...fields.map(
              (f) => Text(
                '${f.field}: ${f.value}',
                style: TextStyle(
                  color: smallWordsColor.withOpacity(0.7),
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
