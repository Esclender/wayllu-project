import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class BottomNavBar extends HookWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: bottomNavBar.withOpacity(0.7),
      child: const Text('This is the Bottom Navigation Bar'),
    );
  }
}
