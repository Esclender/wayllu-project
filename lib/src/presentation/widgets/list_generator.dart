import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/user_info/user_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class CardTemplateItemsList extends HookWidget {
  final ListEnums listType;
  final List<CardTemplate> dataToRender;
  final bool isScrollable;
  final String query;

  // Dependencies Injection
  final appRouter = getIt<AppRouter>();

  CardTemplateItemsList({
    required this.listType,
    required this.dataToRender,
    this.isScrollable = true,
    this.query = '',
  });

  final double navBarHeight = 60.0;
  final double registerUserBtnHeight = 60.0;

  void _navigateToEditUser(UserInfo user) {
    appRouter.navigate(InfoUserRoute(viewIndex: 2, user: user));
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = dataToRender
        .where(
          (item) => item.nombre.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.separated(
      separatorBuilder: (context, index) => const Gap(8),
      physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredData.length,
      itemBuilder: (BuildContext c, int ind) {
        return _buildItemContainer(
          itemData: filteredData[ind],
        );
      },
    );
  }

  Widget _buildItemContainer({
    required CardTemplate itemData,
  }) {
    final BoxDecoration decoration = BoxDecoration(
      color: bottomNavBar,
      boxShadow: [
        simpleShadow,
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    );

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
              decoration: decoration,
              child: _listTile(
                leading: _buildImageAvatar(itemData.url),
                title: Text(itemData.nombre),
                fields: itemData.descriptions,
              ),
            ),
            _itemMarker(
              secondary,
            ),
          ],
        ),
         if (listType == ListEnums.users) _itemEdit(itemData.userInfo) else Container(),
     
      ],
    );
  }

  Widget _buildImageAvatar(String url) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _itemEdit(UserInfo user) {
    return InkWell(
      onTap: () => _navigateToEditUser(user),
      child: Container(
        width: 30,
        height: 25,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.circular(2),
        ),
        child: const Icon(
          Ionicons.pencil,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _itemMarker(Color colorMarker) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 5.0,
      height: 20.0,
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
        const Gap(20),
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
