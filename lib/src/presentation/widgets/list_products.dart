import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/domain/models/models_products.dart';
import 'package:wayllu_project/src/domain/models/products_info/product_info_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class ProductsCardsItemsList extends HookWidget {
  final ListEnums listType;
  final List<Producto> dataToRender;
  final String query;

  //Dependencies Injection
  final appRouter = getIt<AppRouter>();

  ProductsCardsItemsList({
    required this.listType,
    required this.dataToRender,
    this.query = '',
  });

  final double navBarHeight = 60.0;
  final double registerUserBtnHeight = 60.0;

  //[gradient, color]

  void _navigateToEditUser(Producto product) {
    // appRouter.navigate(InfoUserRoute(viewIndex: 2, user: user));
  }

  @override
  Widget build(BuildContext context) {
    print(dataToRender);

    return ListView.separated(
      separatorBuilder: (context, index) => const Gap(8),
      //physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dataToRender.length,
      itemBuilder: (BuildContext c, int ind) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: ind == dataToRender.length - 1
                ? listType == ListEnums.products
                    ? navBarHeight
                    : navBarHeight + 10
                : 0.0,
          ),
          child: _buildItemContainer(
            itemData: dataToRender[ind],
          ),
        );
      },
    );
  }

  Widget _buildItemContainer({
    required Producto itemData,
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
                leading: _buildImageProduct(itemData.imagen),
                title: Text(itemData.product_code),
                fields: itemData.descriptions,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageProduct(String url) {
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
