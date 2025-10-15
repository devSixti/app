import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SecurityContactWidget extends StatelessWidget {
  final VoidCallback onContactSecurity;

  const SecurityContactWidget({
    super.key,
    required this.onContactSecurity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.purpleColor.withOpacity(0.3),
            AppTheme.purpleColor.withOpacity(0.9),
          ],
        ),
        borderRadius: AppTheme.border,
        boxShadow: [
          BoxShadow(
            color: AppTheme.purpleColor,
            blurRadius: 12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onContactSecurity,
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reportar Problema de Seguridad',
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: AppTheme.mediumSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}