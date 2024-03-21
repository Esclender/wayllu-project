import 'package:flutter/material.dart';

class TextLogin extends StatelessWidget {
  const TextLogin({super.key, required this.text, this.colorText});

  final String text;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Portofino',
          color: colorText ?? Colors.white,
          fontSize: 30,),
    );
  }
}
