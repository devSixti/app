// Switch para aceptar automáticamente por el precio

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class AutoAcceptSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const AutoAcceptSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: AppTheme.border,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Aceptar automáticamente por mi precio',
              style: TextStyle(
                fontSize: AppTheme.smallSize + 2,
                color: AppTheme.whiteContainer,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppTheme.purpleColor,
              activeTrackColor: AppTheme.purpleColor.withOpacity(0.5),
              inactiveThumbColor: AppTheme.silver,
              inactiveTrackColor: AppTheme.silverDark,
            ),
          ),
        ],
      ),
    );
  }
}
