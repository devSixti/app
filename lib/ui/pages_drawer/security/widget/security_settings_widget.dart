import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'security_option_widget.dart';

class SecuritySettingsWidget extends StatelessWidget {
  final Function(String) onOptionTap;

  const SecuritySettingsWidget({
    super.key,
    required this.onOptionTap, required bool biometricEnabled, required Null Function(dynamic value) onBiometricChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(
                  Icons.security_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Configuración de Seguridad',
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SecurityOptionWidget(
            title: 'Cambiar Contraseña',
            subtitle: 'Actualiza tu contraseña regularmente',
            icon: Icons.lock_reset_rounded,
            iconColor: AppTheme.silver,
            backgroundIcon: AppTheme.silver.withOpacity(0.3),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('password'),
          ),
          const SizedBox(height: 12),
          SecurityOptionWidget(
            title: 'Autenticación Biométrica',
            subtitle: 'Usa huella dactilar o Face ID',
            icon: Icons.fingerprint_rounded,
            iconColor: AppTheme.silver,
            backgroundIcon: AppTheme.silver.withOpacity(0.3),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('biometric'),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}