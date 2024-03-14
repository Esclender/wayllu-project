import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class TextLoginField extends StatelessWidget {
  const TextLoginField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      this.validator,
      this.maxLength,
      this.onChanged,
      required this.controller,});

  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      onChanged: onChanged ?? (text) {},
      obscureText: obscureText,
      cursorColor: HexColor('#4f4f4f'),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: HexColor('#D16363'),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintStyle: GoogleFonts.poppins(
          fontSize: 15,
          color: const Color.fromARGB(128, 0, 0, 0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(120, 0, 0, 0)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(120, 0, 0, 0)),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
      ),
    );
  }
}
