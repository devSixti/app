import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/drawer_menu/drawer.dart';

class DriverHomeShell extends StatelessWidget {
  const DriverHomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      appBar: AppBar(
        backgroundColor: AppTheme.darkScaffold,
        foregroundColor: AppTheme.whiteContainer,
        elevation: 0,
        title: const Text('Inicio conductor'),
      ),
      drawer: const CustomDrawer(isLogedIn: true, isDriver: true),
      body: Center(
        child: Text(
          'Pantalla principal del conductor',
          style: TextStyle(color: AppTheme.whiteContainer, fontSize: 16),
        ),
      ),
    );
  }
}
