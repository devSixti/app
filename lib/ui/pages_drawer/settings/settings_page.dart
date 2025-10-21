import 'package:app/ui/pages_drawer/settings/widgets/setting_location.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/notifications_settings_widget.dart';
import 'widgets/appearance_settings_widget.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';

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
      backgroundColor: AppTheme.darkScaffold,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                   const SizedBox(height: 20),
                  const WorkAppBar(
                    title: 'Regresar', 
                    showBack: true),
                  const SizedBox(height: 20),

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
