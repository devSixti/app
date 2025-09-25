// Este archivo define los temas claro y oscuro de la aplicación.
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromRGBO(128, 255, 0, 1);
  static const Color purpleColor = Color.fromRGBO(96, 43, 201, 1);
  static const Color purpleLigth = Color.fromRGBO(185, 150, 255, 1);
  static const Color lightPrimaryContainer = Color.fromRGBO(244, 244, 244, 1);
  static const Color whiteContainer = Color.fromRGBO(255, 255, 255, 1);
  static const Color blackContainer = Color.fromRGBO(0, 0, 0, 1);
  static const Color lightBackground = Color.fromRGBO(248, 248, 248, 1);
  static const Color darkBackground = Color.fromRGBO(51, 51, 51, 1);
  static const Color lightGreyContainer = Color.fromRGBO(240, 240, 240, 1);
  static const Color darkGreyContainer = Color.fromRGBO(26, 26, 26, 1);
  static const Color darkDrawerBackground = Color.fromRGBO(29, 27, 31, 1);
  static const Color inputBackgroundDark = Color.fromRGBO(45, 45, 45, 1);
  static const Color inputBackgroundLigth = Color.fromRGBO(240, 240, 240, 1);
  static const Color darkScaffold = Color.fromRGBO(32, 31, 31, 1);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      scaffoldBackgroundColor: inputBackgroundLigth,
      iconTheme: const IconThemeData(
        color: blackContainer,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: lightBackground,
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: purpleColor,
        secondaryFixed: purpleLigth,
        tertiary: lightPrimaryContainer,
        primaryContainer: lightPrimaryContainer,
        secondaryContainer: blackContainer,
        tertiaryContainer: lightGreyContainer,
        onTertiaryContainer: darkGreyContainer,
        surface: lightBackground,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      scaffoldBackgroundColor: darkScaffold,
      iconTheme: const IconThemeData(
        color: whiteContainer,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: darkDrawerBackground,
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: purpleColor,
        secondaryFixed: purpleLigth,
        tertiary: inputBackgroundDark,
        primaryContainer: inputBackgroundDark,
        secondaryContainer: whiteContainer,
        tertiaryContainer: darkGreyContainer,
        onTertiaryContainer: lightGreyContainer,
        surface: inputBackgroundDark,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(),
      ),
    );
  }
}