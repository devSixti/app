import 'package:flutter/material.dart';
import '/ui/screens/select_location_screen.dart';

class NewXistiApp extends StatelessWidget {
  const NewXistiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xisti App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SelectLocationScreen(),
    );
  }
}

class AppTheme {
  static ThemeData? get lightTheme => null;
  static ThemeData? get darkTheme => null;
  static Color? get darkBackground => null;
  static Color? get darkGreyContainer => null;
  static Color? get darkScaffold => null;
  static Color? get primaryColor => null;
  static Color? get purpleColor => null;
}
