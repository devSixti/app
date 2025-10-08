// Este archivo define los temas claros y oscuros de la aplicación.
import 'package:flutter/material.dart';

class AppTheme {
  // COLORES PRINCIPALES DE LA APLICACIÓN
  static const Color primaryColor = Color(0xFF80FF00); // Color principal (verde neón)
  static const Color purpleColor = Color(0xFF602BC9); // Color morado principal
  static const Color purpleLigth = Color.fromRGBO(185, 150, 255, 1); // Morado claro (versión suave del anterior)
  static const Color lightPrimaryContainer = Color.fromRGBO(244, 244, 244, 1); // Fondo gris muy claro para modo claro
  static const Color whiteContainer = Color.fromRGBO(255, 255, 255, 1); // Blanco puro para contenedores o texto
  static const Color blackContainer = Color.fromRGBO(0, 0, 0, 1); // Negro puro para texto o fondos oscuros
  static const Color lightBackground = Color.fromRGBO(248, 248, 248, 1); // Fondo general del modo claro
  static const Color darkBackground = Color.fromRGBO(51, 51, 51, 1); // Fondo general del modo oscuro
  static const Color lightGreyContainer = Color.fromRGBO(240, 240, 240, 1); // Gris claro para campos o tarjetas
  static const Color darkGreyContainer = Color.fromRGBO(26, 26, 26, 1); // Gris oscuro para cajas o paneles en modo oscuro
  static const Color darkDrawerBackground = Color.fromRGBO(29, 27, 31, 1); // Fondo del Drawer (menú lateral) oscuro
  static const Color inputBackgroundDark = Color.fromRGBO(45, 45, 45, 1); // Fondo de inputs en modo oscuro
  static const Color inputBackgroundLigth = Color.fromRGBO(240, 240, 240, 1); // Fondo de inputs en modo claro
  static const Color darkScaffold = Color.fromRGBO(32, 31, 31, 1); // Fondo principal del Scaffold en modo oscuro
  static const double fontSizeLarge = 28.0;

  // CONFIGURACIÓN DEL TEMA CLARO 
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // Usa el sistema Material Design 3
      appBarTheme: const AppBarTheme(
        elevation: 0, // Sin sombra debajo del AppBar
        backgroundColor: Colors.transparent, // AppBar transparente
        centerTitle: true, // Centra el título en el AppBar
      ),
      scaffoldBackgroundColor: inputBackgroundLigth, // Fondo general de las pantallas claras
      iconTheme: const IconThemeData(
        color: blackContainer, // Color de íconos en modo claro (negro)
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: lightBackground, // Fondo del Drawer (menú lateral)
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light, // Indica que este es el modo claro
        seedColor: Colors.white, // Color base del esquema
        primary: Colors.white, // Color principal (líneas de texto o bordes)
        secondary: purpleColor, // Color secundario (botones, íconos destacados)
        secondaryFixed: purpleLigth, // Variante más clara del color secundario
        tertiary: lightPrimaryContainer, // Fondo alternativo para contenedores
        primaryContainer: lightPrimaryContainer, // Fondo de contenedores primarios
        secondaryContainer: blackContainer, // Contenedor secundario (negro)
        tertiaryContainer: lightGreyContainer, // Fondo gris claro alternativo
        onTertiaryContainer: darkGreyContainer, // Texto sobre contenedor terciario
        surface: lightBackground, // Fondo base de la interfaz
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent, // El borde del input cuando está enfocado será invisible
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(), // Usa el estilo por defecto de los botones de texto
      ),
    );
  }

  // CONFIGURACIÓN DEL TEMA OSCURO 
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true, // Usa Material Design 3
      appBarTheme: const AppBarTheme(
        elevation: 0, // Sin sombra en el AppBar
        backgroundColor: Colors.transparent, // AppBar transparente
        centerTitle: true, // Centra el título del AppBar
      ),
      scaffoldBackgroundColor: darkScaffold, // Fondo principal del Scaffold oscuro
      iconTheme: const IconThemeData(
        color: whiteContainer, // Color de íconos en modo oscuro (blanco)
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: darkDrawerBackground, // Fondo del Drawer oscuro
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark, // Indica modo oscuro
        seedColor: const Color.fromRGBO(128, 255, 0, 1), // Color semilla (verde neón)
        primary: primaryColor, // Color principal de acento
        secondary: purpleColor, // Color secundario (morado)
        secondaryFixed: purpleLigth, // Versión clara del color secundario
        tertiary: inputBackgroundDark, // Fondo alternativo oscuro para inputs
        primaryContainer: inputBackgroundDark, // Fondo principal de contenedores oscuros
        secondaryContainer: whiteContainer, // Contenedores secundarios (blancos)
        tertiaryContainer: darkGreyContainer, // Contenedor terciario (gris oscuro)
        onTertiaryContainer: lightGreyContainer, // Texto sobre contenedor terciario
        surface: inputBackgroundDark, // Fondo base de la interfaz oscura
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent, // Quita el borde visible al enfocar el input
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(), // Estilo por defecto de los botones de texto
      ),
    );
  }

  // === PROPIEDADES ADICIONALES (ACTUALMENTE NO DEFINIDAS) ===
  static Color? get backgroundColor => null; // Color de fondo general (sin definir)
  static Color? get cardColor => null; // Color de las tarjetas (sin definir)
  static Color? get dividerColor => null; // Color de las líneas divisoras (sin definir)
  static Color? get inputBackgroundColor => null; // Fondo de inputs (sin definir)
  static Color? get secondaryTextColor => null; // Color de texto secundario (sin definir)
  static Color? get primaryTextColor => null; // Color de texto principal (sin definir)
  static Color? get buttonTextColor => null; // Color del texto en botones (sin definir)
  static Color? get primaryButtonColor => null;

  static Color? get green => null; // Color del botón principal (sin definir)
}
