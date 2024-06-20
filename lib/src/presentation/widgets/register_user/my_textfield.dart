import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.onSaved,
    this.validator,
    this.maxLength,
    this.onChanged,
  });

  final String? Function(String?)? validator;
  final Function(String?) onSaved;
  final String hintText;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      onChanged: onChanged ?? (text) {},
      obscureText: obscureText,
      cursorColor: HexColor('#4f4f4f'),
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
