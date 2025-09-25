import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'form_trips/form_trips.dart';

class NewXistiApp extends StatelessWidget {
  const NewXistiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xisti App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const FormTrips(),
    );
  }
}
