// Archivo de buscar conductor

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SearchDriverButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SearchDriverButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67, // altura más grande
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor, // Color verde original
          foregroundColor: AppTheme.blackContainer, // Color negro original
          shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 45,
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