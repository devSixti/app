import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'settings_section_widget.dart';
import 'settings_switch_widget.dart';

class LocationSettingsWidget extends StatelessWidget {
  final bool locationEnabled;
  final ValueChanged<bool> onLocationChanged;

  const LocationSettingsWidget({
    super.key,
    required this.locationEnabled,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsSectionWidget(
      title: 'Ubicación',
      icon: Icons.location_on_rounded,
      iconColor: AppTheme.primaryColor,
      iconBackgroundColor: AppTheme.primaryColor,
      borderColor: AppTheme.silver,
      children: [
        SettingsSwitchWidget(
          title: 'Ubicación GPS',
          subtitle: 'Permite el acceso a tu ubicación',
          value: locationEnabled,
          onChanged: onLocationChanged,
          icon: Icons.gps_fixed_rounded,
          accentColor: AppTheme.silver,
          onChangedColor: AppTheme.purpleColor,
        ),
      ],
    );
  }
}