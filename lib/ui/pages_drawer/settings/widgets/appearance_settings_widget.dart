import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'settings_section_widget.dart';
import 'settings_selector_widget.dart';

class AppearanceSettingsWidget extends StatelessWidget {
  final String selectedLanguage;
  final String selectedTheme;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<String> onThemeChanged;

  const AppearanceSettingsWidget({
    super.key,
    required this.selectedLanguage,
    required this.selectedTheme,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSectionWidget(
      title: 'Apariencia',
      icon: Icons.palette_rounded,
      iconColor: AppTheme.primaryColor,
      borderColor: AppTheme.silver,
      children: [
        SettingsSelectorWidget(
          title: 'Idioma',
          subtitle: 'Selecciona tu idioma preferido',
          currentValue: selectedLanguage,
          options: const ['Español', 'English', 'Português'],
          onChanged: onLanguageChanged,
          icon: Icons.language_rounded,
          accentColor: AppTheme.silver,
        ),
        const SizedBox(height: 12),
        SettingsSelectorWidget(
          title: 'Tema',
          subtitle: 'Elige el tema de la aplicación',
          currentValue: selectedTheme,
          options: const ['Oscuro', 'Claro', 'Automático'],
          onChanged: onThemeChanged,
          icon: Icons.dark_mode_rounded,
          accentColor: AppTheme.silver,
        ),
      ],
    );
  }
}