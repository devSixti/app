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
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.inputBackgroundDark,
            AppTheme.darkGreyContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.silver.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.2),
                      AppTheme.primaryColor.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
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
            border: AppTheme.silver.withOpacity(0.3),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('password'),
          ),
          const SizedBox(height: 12),
          SecurityOptionWidget(
            title: 'Verificación en Dos Pasos',
            subtitle: 'Agrega una capa extra de seguridad',
            icon: Icons.verified_rounded,
            iconColor: AppTheme.silver,
            backgroundIcon: AppTheme.silver.withOpacity(0.3),
            border: AppTheme.silver.withOpacity(0.3),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('twoFactor'),
          ),
          const SizedBox(height: 12),
          SecurityOptionWidget(
            title: 'Autenticación Biométrica',
            subtitle: 'Usa huella dactilar o Face ID',
            icon: Icons.fingerprint_rounded,
            iconColor: AppTheme.silver,
            backgroundIcon: AppTheme.silver.withOpacity(0.3),
            border: AppTheme.silver.withOpacity(0.3),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('biometric'),
          ),
          const SizedBox(height: 12),
          SecurityOptionWidget(
            title: 'Dispositivos Conectados',
            subtitle: 'Administra tus sesiones activas',
            icon: Icons.devices_rounded,
            iconColor: AppTheme.silver,
            backgroundIcon: AppTheme.silver.withOpacity(0.3),
            border: AppTheme.silver.withOpacity(0.3),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('devices'),
          ),
        ],
      ),
    );
  }
}