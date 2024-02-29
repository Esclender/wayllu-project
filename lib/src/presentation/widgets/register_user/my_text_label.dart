import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextLabel extends StatelessWidget {
  const MyTextLabel({
    super.key,
    required this.hintText,
    this.warText,
  });

  final String hintText;
  final String? warText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          hintText,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          warText ?? '',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[850],
          ),
        ),
      ],
    );
  }
}
