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
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.blackContainer.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
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
            accentColor: AppTheme.primaryColor,
            onTap: () => onOptionTap('downloadData'),
          ),
          const SizedBox(height: 12),
          SecurityOptionWidget(
            title: 'Eliminar mi Cuenta',
            subtitle: 'Eliminar permanentemente tu cuenta',
            icon: Icons.delete_forever_rounded,
            accentColor: Colors.red,
            onTap: () => onOptionTap('deleteAccount'),
          ),
          const SizedBox(height: 12),
          SecurityOptionWidget(
            title: 'Política de Privacidad',
            subtitle: 'Lee cómo manejamos tu información',
            icon: Icons.policy_rounded,
            accentColor: AppTheme.purpleColor,
            onTap: () => onOptionTap('privacyPolicy'),
          ),
        ],
      ),
    );
  }
}