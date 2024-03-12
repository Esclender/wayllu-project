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
HexColor noSelectedView = HexColor('#646369');
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

LinearGradient gradientLogin = const LinearGradient(
  stops: [0.01, 1],
  begin: FractionalOffset.bottomLeft,
  end: FractionalOffset.topRight,
  colors: [
    Color(0xFFFFA743),
    Color(0xFFB80000),
  ],
);

//Box shadows

BoxShadow simpleShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5), // Color of the shadow
  spreadRadius: 1, // Spread radius of the shadow
  blurRadius: 7, // Blur radius of the shadow
  offset: const Offset(0, 3), // Offset of the shadow
);
