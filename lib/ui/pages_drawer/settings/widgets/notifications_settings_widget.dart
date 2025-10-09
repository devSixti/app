import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'settings_section_widget.dart';
import 'settings_switch_widget.dart';

class NotificationsSettingsWidget extends StatelessWidget {
  final bool notificationsEnabled;
  final bool soundEnabled;
  final ValueChanged<bool> onNotificationsChanged;
  final ValueChanged<bool> onSoundChanged;

  const NotificationsSettingsWidget({
    super.key,
    required this.notificationsEnabled,
    required this.soundEnabled,
    required this.onNotificationsChanged,
    required this.onSoundChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSectionWidget(
      title: 'Notificaciones',
      icon: Icons.notifications_rounded,
      accentColor: AppTheme.primaryColor,
      children: [
        SettingsSwitchWidget(
          title: 'Notificaciones Push',
          subtitle: 'Recibe alertas de viajes y promociones',
          value: notificationsEnabled,
          onChanged: onNotificationsChanged,
          icon: Icons.notifications_active_rounded,
          accentColor: AppTheme.primaryColor,
        ),
        SettingsSwitchWidget(
          title: 'Sonidos',
          subtitle: 'Sonidos para notificaciones',
          value: soundEnabled,
          onChanged: onSoundChanged,
          icon: Icons.volume_up_rounded,
          accentColor: AppTheme.primaryColor,
        ),
      ],
    );
  }
}