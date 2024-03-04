import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/domain/enums/user_roles.dart';
import 'package:wayllu_project/src/domain/models/bottom_navbar_options_model.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/presentation/cubit/is_admin_cubit.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class BottomNavBar extends HookWidget {
  final int viewSelected;

  BottomNavBar({super.key, this.viewSelected = 0});

  final List<OptionsIcons> optionsIcons = [
    OptionsIcons(
      icon: Ionicons.home,
      routes: [
        OptionsIconsRoutes(route: '/home', rol: UserRoles.all),
      ],
    ),
    OptionsIcons(
      icon: Ionicons.bar_chart,
      routes: [
        OptionsIconsRoutes(route: '/carrito', rol: UserRoles.admin),
      ],
    ),
    OptionsIcons(
      icon: Ionicons.person,
      routes: [
        OptionsIconsRoutes(route: '/user/info', rol: UserRoles.artesano),
        OptionsIconsRoutes(route: '/admin/users-list', rol: UserRoles.admin),
      ],
    ),
  ];

  //Dependencies Injection
  final appRouter = getIt<AppRouter>();

  final double blur = 1.5;
  final BorderRadiusGeometry containersBorder = const BorderRadius.all(
    Radius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    final UserRoles rol = context.read<UserLoggedCubit>().state;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: bottomNavBar.withOpacity(0.8),
        borderRadius: containersBorder,
        border: Border(
          top: BorderSide(color: bottomNavBarStroke),
          left: BorderSide(color: bottomNavBarStroke),
          right: BorderSide(color: bottomNavBarStroke),
        ),
      ),
      child: ClipRRect(
        borderRadius: containersBorder,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blur,
            sigmaY: blur,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              optionsIcons.length,
              (index) {
                try {
                  final OptionsIconsRoutes optionForThisRol =
                      optionsIcons[index].routes.firstWhere(
                            (opt) => opt.rol == rol || opt.rol == UserRoles.all,
                          );

                  return _buildOptions(
                    optionsIcons[index].icon,
                    optionForThisRol,
                    context,
                    index,
                    rol,
                  );
                } catch (e) {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(
    IconData icon,
    OptionsIconsRoutes optionForThisRol,
    BuildContext context,
    int index,
    UserRoles rol,
  ) {
    return Flexible(
      child: InkWell(
        onTap: () {
          appRouter.navigateNamed(optionForThisRol.route);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 10.0),
          decoration: BoxDecoration(
            color: bottomNavBar,
            borderRadius: containersBorder,
            border: Border.all(color: bottomNavBarStroke, width: 0.4),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: viewSelected == index ? secondaryColor : noSelectedView,
          ),
        ),
      ),
    );
  }
}
