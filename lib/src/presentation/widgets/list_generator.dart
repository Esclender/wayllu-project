import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/domain/enums/lists_enums.dart';
import 'package:wayllu_project/src/domain/models/list_items_model.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class ColorfullItemsList extends HookWidget {
  final ListEnums listType;

  ColorfullItemsList({
    required this.listType,
  });

  final double navBarHeight = 60.0;
  final double registerUserBtnHeight = 60.0;

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

  //[gradient, color]
  final List<List> gradients = [
    [gradientMain, mainColor],
    [gradientSecondary, secondaryColor],
    [gradientThird, thirdColor],
    [gradientFourth, fourthColor],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Gap(35),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (BuildContext c, int ind) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom:
                ind == 19 ? navBarHeight + (registerUserBtnHeight * 2) : 0.0,
          ),
          child: _buildItemContainer(
            itemData: data[0],
          ),
        );
      },
    );
  }

  Widget _buildItemContainer({
    required ColorfullItem itemData,
  }) {
    final int random = Random().nextInt(3);

    final BoxDecoration decoration = BoxDecoration(
      boxShadow: [
        simpleShadow,
      ],
      gradient: gradients[random][0] as Gradient,
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
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(itemData.url),
                ),
                title: Text(itemData.nombre),
                fields: itemData.descriptions,
              ),
            ),
            _itemMarker(
              gradients[random][1] as Color,
            ),
          ],
        ),
        if (listType == ListEnums.users) _itemEdit() else Container(),
      ],
    );
  }

  Widget _itemEdit() {
    return Container(
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
