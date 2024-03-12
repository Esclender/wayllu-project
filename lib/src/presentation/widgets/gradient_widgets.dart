import 'package:flutter/material.dart';
import 'package:wayllu_project/src/utils/constants/colors.dart';

class GradientText extends StatelessWidget {
  final String text;

  final double fontSize;
  final FontWeight fontWeight;

  GradientText({
    super.key,
    required this.text,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
  });

  final Gradient gradient = LinearGradient(
    colors: [mainColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GradientDecoration extends StatelessWidget {
  final double width;

  GradientDecoration({
    super.key,
    this.width = 14.0,
  });

  final Gradient gradient = LinearGradient(
    colors: [mainColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Container(
        width: width,
        height: 2.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
