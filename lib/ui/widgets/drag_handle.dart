// Este es el archivo que contiene el widget DragHandle (El manejador de arrastre)

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppTheme.silverDark,
          borderRadius: AppTheme.border,
        ),
      ),
    );
  }
}