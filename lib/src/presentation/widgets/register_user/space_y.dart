import 'package:flutter/material.dart';

class SpaceY extends StatelessWidget {
  const SpaceY({
    super.key,
    this.value,
  });

  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value ?? 20);
  }
}
