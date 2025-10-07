// Este es el archivo principal que contiene el widget NewXistiApp (la aplicación principal)

import 'package:app/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
// Nueva pantalla de carga (Splash)
// import 'package:app/ui/form_trips/widgets/login_screen.dart';

class NewXistiApp extends StatelessWidget {
  const NewXistiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la etiqueta DEBUG
      title: 'Xisti', // Nombre mostrado en el launcher
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      home: const SplashScreen(),
    );
  }
}
