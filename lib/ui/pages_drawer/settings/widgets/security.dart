import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'settings_section_widget.dart';
import 'settings_switch_widget.dart';

class SecuritySettingsWidget extends StatelessWidget {
  final bool biometricEnabled;
  final ValueChanged<bool> onBiometricChanged;

  const SecuritySettingsWidget({
    super.key,
    required this.biometricEnabled,
    required this.onBiometricChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSectionWidget(
      title: 'Seguridad',
      icon: Icons.security_rounded,
      iconColor: AppTheme.primaryColor,
      borderColor: AppTheme.silver,
      children: [
        SettingsSwitchWidget(
          title: 'Autenticación Biométrica',
          subtitle: 'Usa huella dactilar para iniciar sesión',
          value: biometricEnabled,
          onChanged: onBiometricChanged,
          icon: Icons.fingerprint_rounded,
          accentColor: AppTheme.purpleColor,
        ),
      ],
    );
  }
}