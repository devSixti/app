// Este archivo define los temas claros y oscuros de la aplicación.
import 'package:flutter/material.dart';

class AppTheme {
  // COLORES PRINCIPALES DE LA APLICACIÓN
  static const Color primaryColor = Color(
    0xFF80FF00,
  ); // Color principal (verde neón)
  static const Color purpleColor = Color(0xFF602BC9); // Color morado principal
  static const Color purpleLigth = Color(
    0xFFB996FF,
  ); // Morado claro (versión suave del anterior)
  static const Color lightPrimaryContainer = Color(
    0xFFF4F4F4,
  ); // Fondo gris muy claro para modo claro
  static const Color whiteContainer = Color(
    0xFFFFFFFF,
  ); // Blanco puro para contenedores o texto
  static const Color blackContainer = Color(
    0xFF000000,
  ); // Negro puro para texto o fondos oscuros
  static const Color lightBackground = Color(
    0xFFF8F8F8,
  ); // Fondo general del modo claro
  static const Color darkBackground = Color(
    0xFF333333,
  ); // Fondo general del modo oscuro
  static const Color lightGreyContainer = Color(
    0xFFF0F0F0,
  ); // Gris claro para campos o tarjetas
  static const Color darkGreyContainer = Color(
    0xFF1A1A1A,
  ); // Gris oscuro para cajas o paneles en modo oscuro
  static const Color darkDrawerBackground = Color(
    0xFF1D1B1F,
  ); // Fondo del Drawer (menú lateral) oscuro
  static const Color inputBackgroundDark = Color(
    0xFF2D2D2D,
  ); // Fondo de inputs en modo oscuro
  static const Color inputBackgroundLigth = Color(
    0xFFF0F0F0,
  ); // Fondo de inputs en modo claro
  static const Color darkScaffold = Color(
    0xFF201F1F,
  ); // Fondo principal del Scaffold en modo oscuro

  // TAMAÑOS DE LETRAS PREDETERMINADOS
  static const double extraLargeSize = 32.0; // (30 hasta 35)
  static const double largeSize = 26.0; // (22 hasta 29)
  static const double mediumSize = 18.0; // (15 hasta 21)
  static const double smallSize = 12.0; // (9 hasta 14)
  static const double extraSmallSize = 6.0; // (3 hasta 8)

  // BORDER RADIUS
  static const BorderRadius border = BorderRadius.all(Radius.circular(15));


  // CONFIGURACIÓN DEL TEMA CLARO
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // Usa el sistema Material Design 3
      appBarTheme: const AppBarTheme(
        elevation: 0, // Sin sombra debajo del AppBar
        backgroundColor: Colors.transparent, // AppBar transparente
        centerTitle: true, // Centra el título en el AppBar
      ),
      scaffoldBackgroundColor:
          inputBackgroundLigth, // Fondo general de las pantallas claras
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
        primaryContainer:
            lightPrimaryContainer, // Fondo de contenedores primarios
        secondaryContainer: blackContainer, // Contenedor secundario (negro)
        tertiaryContainer: lightGreyContainer, // Fondo gris claro alternativo
        onTertiaryContainer:
            darkGreyContainer, // Texto sobre contenedor terciario
        surface: lightBackground, // Fondo base de la interfaz
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors
                .transparent, // El borde del input cuando está enfocado será invisible
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(), // Usa el estilo por defecto de los botones de texto
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
      scaffoldBackgroundColor:
          darkScaffold, // Fondo principal del Scaffold oscuro
      iconTheme: const IconThemeData(
        color: whiteContainer, // Color de íconos en modo oscuro (blanco)
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: darkDrawerBackground, // Fondo del Drawer oscuro
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark, // Indica modo oscuro
        seedColor: const Color.fromRGBO(
          128,
          255,
          0,
          1,
        ), // Color semilla (verde neón)
        primary: primaryColor, // Color principal de acento
        secondary: purpleColor, // Color secundario (morado)
        secondaryFixed: purpleLigth, // Versión clara del color secundario
        tertiary: inputBackgroundDark, // Fondo alternativo oscuro para inputs
        primaryContainer:
            inputBackgroundDark, // Fondo principal de contenedores oscuros
        secondaryContainer:
            whiteContainer, // Contenedores secundarios (blancos)
        tertiaryContainer:
            darkGreyContainer, // Contenedor terciario (gris oscuro)
        onTertiaryContainer:
            lightGreyContainer, // Texto sobre contenedor terciario
        surface: inputBackgroundDark, // Fondo base de la interfaz oscura
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors
                .transparent, // Quita el borde visible al enfocar el input
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(), // Estilo por defecto de los botones de texto
      ),
    );
  }
}