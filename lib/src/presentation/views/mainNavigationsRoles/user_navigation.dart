import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class UserNavigationScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
