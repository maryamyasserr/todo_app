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

  static Color primaryDarkMode = Color(0xff141A2E);
  static Color secondaryDarkMode = Color(0xffFACC1D);
  static Color selectedColor = Color(0xff242424);
  static Color selectedDarkColor = Color(0xffFACC1D);
  static Color unselectedColor = Color(0xffFFFFFF);

  static bool isDark = true;

  static ThemeData lightMode = ThemeData(
      primaryColor: primaryLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryLight,
        primary: primaryLight,
        onSecondary: selectedColor,
        onPrimary: primaryLight,
        onBackground: const Color(0xffF8F8F8),
      ),
      scaffoldBackgroundColor: backgroundColorLight,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
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
          bodyLarge: GoogleFonts.poppins(
              color: primaryLight, fontSize: 18, fontWeight: FontWeight.bold),
          bodyMedium: GoogleFonts.roboto(
              color: blackColor, fontSize: 15, fontWeight: FontWeight.bold),
          titleSmall: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
      ));
  static ThemeData darkMode = ThemeData(
    primaryColor: primaryDarkMode,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryDarkMode,
      primary: primaryDarkMode,
      onSecondary: secondaryDarkMode,
      onPrimary: secondaryDarkMode,
      onBackground: primaryDarkMode,
    ),
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true),
    dividerColor: secondaryDarkMode,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: selectedDarkColor,
        unselectedItemColor: unselectedColor,
        backgroundColor: primaryDarkMode),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.elMessiri(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        titleMedium: GoogleFonts.elMessiri(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        titleSmall: GoogleFonts.elMessiri(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal)),
  );
}
