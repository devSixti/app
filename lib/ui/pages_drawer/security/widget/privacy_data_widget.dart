import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'security_option_widget.dart';

class PrivacyDataWidget extends StatelessWidget {
  final Function(String) onOptionTap;

  const PrivacyDataWidget({
    super.key,
    required this.onOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.darkScaffold,
        borderRadius: AppTheme.border,
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
                  Icons.privacy_tip_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Privacidad y Datos',
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
            title: 'Descargar mis Datos',
            subtitle: 'Obtén una copia de tu información',
            icon: Icons.download_rounded,
            iconColor: AppTheme.silver,
            backgroundIcon: AppTheme.silver.withOpacity(0.1),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('downloadData'),
          ),

          const SizedBox(height: 12),

          SecurityOptionWidget(
            title: 'Política de Privacidad',
            subtitle: 'Lee cómo manejamos tu información',
            icon: Icons.policy_rounded,
            iconColor: AppTheme.silver,
            backgroundIcon: AppTheme.silver.withOpacity(0.1),
            titleColor: AppTheme.whiteContainer,
            subtitleColor: AppTheme.whiteContainer,
            onTap: () => onOptionTap('privacyPolicy'),
          ),

          const SizedBox(height: 12),

          SecurityOptionWidget(
            title: 'Eliminar mi Cuenta',
            subtitle: 'Eliminar permanentemente tu cuenta',
            icon: Icons.delete_forever_rounded,
            iconColor: AppTheme.red,
            backgroundIcon: AppTheme.red.withOpacity(0.1),
            titleColor: AppTheme.red,
            subtitleColor: AppTheme.red,
            onTap: () => onOptionTap('deleteAccount'),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}