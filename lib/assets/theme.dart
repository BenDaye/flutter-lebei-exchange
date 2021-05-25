import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static TextTheme textTheme = TextTheme(
    headline6: GoogleFonts.oswald(),
    headline5: GoogleFonts.oswald(),
    headline4: GoogleFonts.oswald(),
    headline3: GoogleFonts.oswald(),
    headline2: GoogleFonts.oswald(),
    headline1: GoogleFonts.oswald(),
    subtitle1: GoogleFonts.oswald(),
    subtitle2: GoogleFonts.oswald(),
    bodyText1: GoogleFonts.oswald(),
    bodyText2: GoogleFonts.oswald(),
    caption: GoogleFonts.oswald(),
    button: GoogleFonts.oswald(),
    overline: GoogleFonts.oswald(),
  );

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColorBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      accentColorBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
      colorScheme: isDarkTheme
          ? ThemeData.dark().colorScheme.copyWith(
                primary: Colors.orange,
                background: Colors.grey[800],
              )
          : ThemeData.light().colorScheme.copyWith(
                primary: Colors.orange,
                background: Colors.white,
              ),
      textTheme:
          isDarkTheme ? ThemeData.dark().textTheme.merge(textTheme) : ThemeData.light().textTheme.merge(textTheme),
      primaryTextTheme: isDarkTheme
          ? ThemeData.dark().primaryTextTheme.merge(textTheme)
          : ThemeData.light().primaryTextTheme.merge(textTheme),
      primarySwatch: Colors.orange,
      primaryColor: Colors.orange,
      accentColor: Colors.orange,
      backgroundColor: isDarkTheme ? Colors.grey[800] : Colors.white,
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.orange, width: 2.0))),
        labelStyle: GoogleFonts.oswald().copyWith(fontWeight: FontWeight.bold),
        labelColor: Colors.orange,
        unselectedLabelStyle: GoogleFonts.oswald(),
        unselectedLabelColor:
            isDarkTheme ? ThemeData.dark().unselectedWidgetColor : ThemeData.light().unselectedWidgetColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? ThemeData.dark().bottomAppBarColor : ThemeData.light().bottomAppBarColor,
        textTheme:
            isDarkTheme ? ThemeData.dark().textTheme.merge(textTheme) : ThemeData.light().textTheme.merge(textTheme),
      ),
    );
  }
}
