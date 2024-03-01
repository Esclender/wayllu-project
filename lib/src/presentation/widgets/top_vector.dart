import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TopVector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Image.asset(
        'assets/Vector-Top.png',
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
