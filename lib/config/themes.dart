import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme {
  LightTheme,
  DarkTheme,
}

class Themes {
  static final Map<AppTheme, ThemeData> themeData = {
    AppTheme.LightTheme: ThemeData.light().copyWith(
      primaryTextTheme: GoogleFonts.montserratTextTheme().copyWith(
        headline6: TextStyle(
          color: Color(0xffA53860),
          fontFamily: 'Anybody',
          fontStyle: FontStyle.italic,
          fontSize: 20,
        ),
      ),
      brightness: Brightness.light,
      primaryColor: Color(0xff450920),
      buttonColor: Color(0xFFDA627D),
      accentColor: Color(0xFFDA627D),
      backgroundColor: Color(0xffEAE2DA),
      scaffoldBackgroundColor: Color(0xffEAE2DA),
      bottomAppBarColor: Color(0xffA53860),
    ),
    AppTheme.DarkTheme: ThemeData.dark().copyWith(
      primaryTextTheme: GoogleFonts.montserratTextTheme().copyWith(
        headline6: TextStyle(
          color: Color(0xffA53860),
          fontFamily: 'Anybody',
          fontStyle: FontStyle.italic,
          fontSize: 20,
        ),
      ),
      brightness: Brightness.dark,
      primaryColor: Colors.grey,
      buttonColor: Colors.grey,
      accentColor: Colors.grey,
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
      bottomAppBarColor: Colors.grey,
    )
  };
}
