// este archivo define un widget DriverModeButton que representa un botón para activar el modo conductor en un drawer.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import '../../pages_drawer/main_driver_page.dart';

class DriverModeButton extends StatelessWidget {
  const DriverModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainDriverPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Color.fromRGBO(0, 0, 0, 1),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
          elevation: 0,
        ),
        child: const Text(
          'Modo Conductor',
          style: TextStyle(
            fontSize: AppTheme.mediumSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
