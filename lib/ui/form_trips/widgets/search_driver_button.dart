// Archivo de buscar conductor

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SearchDriverButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SearchDriverButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // altura más grande
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(
            255,
            153,
            255,
            0,
          ), // Color verde original
          foregroundColor: Color.fromRGBO(0, 0, 0, 1), // Color negro original
          shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
          padding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 48,
          ), // padding más ajustado
        ),
        onPressed: onPressed,
        child: const Text(
          "Buscar\nconductor",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppTheme.mediumSize, // texto más grande
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
