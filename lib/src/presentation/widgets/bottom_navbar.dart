import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wayllu_project/src/config/router/app_router.dart';
import 'package:wayllu_project/src/locator.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

//final viewSelected = useState(0);

class BottomNavBar extends HookWidget {
  final int viewSelected;

  BottomNavBar({super.key, this.viewSelected = 0});

  final List<Map<String, dynamic>> optionsIcons = [
    {'icon': Ionicons.home, 'route': '/'},
    //{'icon': Ionicons.bar_chart, 'route': '/home'},
    {'icon': Ionicons.person, 'route': '/info-user'},
  ];

  //Dependencies Injection
  final appRouter = getIt<AppRouter>();

  final double blur = 1.5;
  final BorderRadiusGeometry containersBorder = const BorderRadius.all(
    Radius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
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
              (index) => _buildOptions(
                optionsIcons[index]['icon'] as IconData,
                index,
                optionsIcons[index]['route'] as String,
                context,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(
    IconData icon,
    int index,
    String route,
    BuildContext context,
  ) {
    return Flexible(
      child: InkWell(
        onTap: () {
          appRouter.navigateNamed(route);
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
