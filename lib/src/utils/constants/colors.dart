import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

HexColor bgPrimary = HexColor('#FCF6F0');
HexColor txtColor = HexColor('#241E20');
HexColor subtxtColor = HexColor('#919191');
HexColor secondary = HexColor('#FFA743');
HexColor loginBottom = HexColor('#f7963c');
HexColor btnprimary = HexColor('#B80000');
HexColor btnsecondary = HexColor('#FA9C3F');
HexColor bottomNavBar = HexColor('#FFFFFF');
HexColor bgContainer = HexColor('#FFFFFF');
HexColor bottomNavBarStroke = HexColor('#919191');
HexColor noSelectedView = HexColor('#919191');
HexColor mainColor = HexColor('#B80000');
HexColor secondaryColor = HexColor('#FFA743');
HexColor thirdColor = HexColor('#A4B304');
HexColor fourthColor = HexColor('#007A98');
HexColor iconColor = HexColor('#241E20');
HexColor clearLetters = HexColor('#DADADA');
HexColor smallWordsColor = HexColor('#0D1829');
HexColor gradientWhite = HexColor('#F3F6FF');
HexColor line = HexColor('#D8DBDF');
HexColor subs = HexColor('#5A5A5A');
HexColor buttontotal = HexColor('#A4B304');
HexColor estadotxt = HexColor('#25924D');

//Gradients
LinearGradient gradientMain = LinearGradient(
  colors: [
    gradientWhite,
    mainColor,
  ],
);

LinearGradient gradientSecondary = LinearGradient(
  colors: [
    gradientWhite,
    secondaryColor,
  ],
);

LinearGradient gradientThird = LinearGradient(
  colors: [
    gradientWhite,
    thirdColor,
  ],
);

LinearGradient gradientFourth = LinearGradient(
  colors: [
    gradientWhite,
    fourthColor,
  ],
);

LinearGradient gradientOrange = LinearGradient(
  colors: [
    HexColor('#B80000'),
    HexColor('#FFA743'),
  ],
);

LinearGradient loginGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: [
    Color(0xFFFE8769), 
    Color(0xFFEF4736),
    Color(0xFFF76510), 
  ],
  stops: [0.0, 0.5, 1.0],
);

//Box shadows

BoxShadow simpleShadow = BoxShadow(
  color: const Color.fromARGB(255, 95, 95, 95).withOpacity(0.08),
  spreadRadius: 2,
  blurRadius: 4,
  offset: const Offset(
    0,
    1,
  ),
);
BoxShadow strongShadow = BoxShadow(
  color: const Color.fromARGB(255, 95, 95, 95)
      .withOpacity(0.15), // Color y opacidad de la sombra
  spreadRadius: 3, // Radio de expansión de la sombra
  blurRadius: 8, // Radio de difuminado de la sombra
  offset: const Offset(0, 2), // Desplazamiento de la sombra
);
