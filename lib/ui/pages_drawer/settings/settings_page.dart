import 'package:app/ui/pages_drawer/settings/widgets/setting_location.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/settings_header_widget.dart';
import 'widgets/notifications_settings_widget.dart';
import 'widgets/appearance_settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool locationEnabled = true;
  bool darkModeEnabled = true;
  bool soundEnabled = true;
  bool biometricEnabled = false;
  String selectedLanguage = 'Español';
  String selectedTheme = 'Oscuro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          const SettingsHeaderWidget(),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Notificaciones
                  NotificationsSettingsWidget(
                    notificationsEnabled: notificationsEnabled,
                    soundEnabled: soundEnabled,
                    onNotificationsChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                    onSoundChanged: (value) {
                      setState(() {
                        soundEnabled = value;
                      });
                    },
                  ),
                  
                  // Ubicación
                  LocationSettingsWidget(
                    locationEnabled: locationEnabled,
                    onLocationChanged: (value) {
                      setState(() {
                        locationEnabled = value;
                      });
                    },
                  ),
                  
                  // Apariencia
                  AppearanceSettingsWidget(
                    selectedLanguage: selectedLanguage,
                    selectedTheme: selectedTheme,
                    onLanguageChanged: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                    },
                    onThemeChanged: (value) {
                      setState(() {
                        selectedTheme = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}