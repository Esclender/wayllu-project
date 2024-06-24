import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

// ignore: must_be_immutable
class TextLoginField extends StatelessWidget {
  const TextLoginField({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.maxLength,
    this.onChanged,
    this.isOnlyNumbers = false,
    required this.controller,
  });

  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final bool isOnlyNumbers;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      onChanged: onChanged ?? (text) {},
      obscureText: obscureText,
      cursorColor: HexColor('#4f4f4f'),
      validator: validator,
      keyboardType: isOnlyNumbers ? TextInputType.number : null,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: iconColor.withOpacity(0.15),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(120, 0, 0, 0), width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(120, 0, 0, 0), width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
      ),
    );
  }
}
