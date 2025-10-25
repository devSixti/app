// Item individual de ubicación con ícono y texto

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class LocationItem extends StatelessWidget {
  final String location;
  final Color iconColor;
  final String label;

  const LocationItem({
    super.key,
    required this.location,
    required this.iconColor,
    required this.label,
  });

  String _getPinImage() {
    // Verde para origen (R), Morado para destino (I)
    if (iconColor == AppTheme.primaryColor) {
      return 'assets/images/pin_verde.png';
    } else {
      return 'assets/images/pin_morado.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label y ícono
        Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: AppTheme.smallSize,
                  color: AppTheme.silver,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                _getPinImage(),
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Texto de la ubicación
        Expanded(
          child: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: AppTheme.smallSize,
              color: AppTheme.whiteContainer,
            ),
          ),
        ),
      ],
    );
  }
}
