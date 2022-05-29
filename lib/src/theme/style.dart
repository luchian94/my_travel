import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(_blackPrimaryValue),
    100: Color(_blackPrimaryValue),
    200: Color(_blackPrimaryValue),
    300: Color(_blackPrimaryValue),
    400: Color(_blackPrimaryValue),
    500: Color(_blackPrimaryValue),
    600: Color(_blackPrimaryValue),
    700: Color(_blackPrimaryValue),
    800: Color(_blackPrimaryValue),
    900: Color(_blackPrimaryValue),
  },
);
const int _blackPrimaryValue = 0xFF000000;

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: primaryBlack,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.robotoTextTheme(),
  );
}
