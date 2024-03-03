import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

HexColor bgPrimary = HexColor('#FCF6F0');
HexColor bottomNavBar = HexColor('#FFFFFF');
HexColor bgContainer = HexColor('#FFFFFF');
HexColor bottomNavBarStroke = HexColor('#919191');
HexColor noSelectedView = HexColor('#646369');
HexColor mainColor = HexColor('#B80000');
HexColor secondaryColor = HexColor('#FFA743');
HexColor thirdColor = HexColor('#A4B304');
HexColor fourthColor = HexColor('#007A98');
HexColor iconColor = HexColor('#241E20');
HexColor clearLetters = HexColor('#DADADA');
HexColor smallWordsColor = HexColor('#0D1829');
HexColor gradientWhite = HexColor('#F3F6FF');

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

//Box shadows

BoxShadow simpleShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5), // Color of the shadow
  spreadRadius: 1, // Spread radius of the shadow
  blurRadius: 7, // Blur radius of the shadow
  offset: const Offset(0, 3), // Offset of the shadow
);
