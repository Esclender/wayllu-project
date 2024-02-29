import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.maxLength,
    this.onChanged,
  });

  TextEditingController controller = TextEditingController();
  final String hintText;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      onChanged: onChanged ?? (text) {},
      controller: controller,
      obscureText: obscureText,
      cursorColor: HexColor('#4f4f4f'),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.transparent,
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
