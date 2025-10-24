// Botón Comenzar — estilo similar a SearchDriverButton
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class ComenzarButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ComenzarButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.blackContainer,
          shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 45),
        ),
        onPressed: onPressed,
        child: const Text(
          'Comenzar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppTheme.mediumSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
