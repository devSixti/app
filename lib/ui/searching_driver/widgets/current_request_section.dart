// Sección que muestra la solicitud actual con las direcciones

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'location_item.dart';

class CurrentRequestSection extends StatelessWidget {
  final String startLocation;
  final String endLocation;

  const CurrentRequestSection({
    super.key,
    required this.startLocation,
    required this.endLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        const Text(
          'Tu solicitud actual',
          style: TextStyle(
            fontSize: AppTheme.mediumSize,
            fontWeight: FontWeight.bold,
            color: AppTheme.whiteContainer,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Ubicación inicial (verde)
        LocationItem(
          location: startLocation,
          iconColor: AppTheme.primaryColor,
          label: '(R)',
        ),
        
        const SizedBox(height: 12),
        
        // Ubicación final (morado)
        LocationItem(
          location: endLocation,
          iconColor: AppTheme.purpleColor,
          label: '(I)',
        ),
      ],
    );
  }
}
