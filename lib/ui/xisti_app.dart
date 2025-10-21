// Este es el archivo principal que contiene el widget NewXistiApp (la aplicación principal)

import 'package:app/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Nueva pantalla de carga (Splash)
// import 'package:app/ui/form_trips/widgets/login_screen.dart';

class NewXistiApp extends StatelessWidget {
  const NewXistiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la etiqueta DEBUG
      title: 'Xisti', // Nombre mostrado en el launcher
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      // Localización: habilita español en toda la app
      locale: const Locale('es', ''), // Fija español; elimina esta línea si prefieres seguir el idioma del sistema
      supportedLocales: const [
        Locale('es', ''),
        Locale('en', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: const SplashScreen(),
    );
  }
}
