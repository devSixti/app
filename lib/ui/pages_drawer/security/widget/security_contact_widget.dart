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
            Colors.orange.withOpacity(0.8),
            Colors.orange.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
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
                Icon(
                  Icons.security_rounded,
                  color: AppTheme.whiteContainer,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Reportar Problema de Seguridad',
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
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