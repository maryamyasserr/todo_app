import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color backgroundColorLight = const Color(0xffDFECDB);
  static Color primaryLight = const Color(0xff5D9CEC);
  static Color greenColor = const Color(0xff61E757);
  static Color redColor = const Color(0xffEC4B4B);
  static Color blackColor = const Color(0xff383838);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color greyColor = const Color(0xffC8C9CB);

  static Color backgroundColorDark = const Color(0xff060E1E);
  static Color primaryDark = const Color(0xff141922);
  static Color selectedDarkColor = Color(0xff5D9CEC);
  static Color unselectedColor = Color(0xffC8C9CB);

  static bool isDark = true;

  static ThemeData lightMode = ThemeData(
      primaryColor: primaryLight,
      colorScheme: ColorScheme.fromSeed(
          seedColor: primaryLight,
          primary: primaryLight,
          onPrimary: whiteColor,
          onBackground: backgroundColorLight,
          onSecondary: blackColor),
      scaffoldBackgroundColor: backgroundColorLight,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: primaryLight,
          elevation: 0,
          toolbarHeight: 100,
          titleTextStyle: GoogleFonts.poppins(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          centerTitle: false),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryLight,
          unselectedItemColor: greyColor,
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.poppins(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          bodyLarge: GoogleFonts.poppins(
              color: primaryLight, fontSize: 18, fontWeight: FontWeight.bold),
          bodyMedium: GoogleFonts.roboto(
              color: blackColor, fontSize: 18, fontWeight: FontWeight.w500),
          titleSmall: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.normal)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
      ));
  static ThemeData darkMode = ThemeData(
    primaryColor: backgroundColorDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryLight,
      primary: primaryLight,
      onSecondary: whiteColor,
      onPrimary: primaryDark,
      onBackground: backgroundColorDark,
    ),
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: primaryLight,
        elevation: 0,
        toolbarHeight: 100,
        titleTextStyle: GoogleFonts.poppins(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        centerTitle: false),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: selectedDarkColor,
        unselectedItemColor: unselectedColor,
        backgroundColor: primaryDark),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
            color: primaryDark, fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: GoogleFonts.poppins(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.poppins(
            color: primaryLight, fontSize: 18, fontWeight: FontWeight.bold),
        bodyMedium: GoogleFonts.roboto(
            color: primaryLight, fontSize: 18, fontWeight: FontWeight.w500),
        titleSmall: GoogleFonts.roboto(
            color: whiteColor, fontSize: 15, fontWeight: FontWeight.normal)),
  );
}
