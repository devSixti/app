import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class VerificationActionButton extends StatelessWidget {
  final String text;

  const VerificationActionButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // placeholder: activar verificación
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verificación activada (simulada)')));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.blackContainer,
          shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      ),
    );
  }
}
