// Archivo del buttom "Guardar cambios"

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null, // Deshabilitado
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(
            128,
            255,
            0,
            1,
          ), // Verde original de la App
          foregroundColor: Color.fromRGBO(0, 0, 0, 1),
          disabledBackgroundColor: const Color.fromRGBO(128, 255, 0, 1),
          disabledForegroundColor: Color.fromRGBO(
            0,
            0,
            0,
            1,
          ), // Color negro original de la App
          shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Guardar cambios',
          style: TextStyle(
            fontSize: AppTheme.mediumSize,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
