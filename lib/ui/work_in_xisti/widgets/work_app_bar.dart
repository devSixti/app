// Este widget define una barra superior personalizada (AppBar) reutilizable
// para todas las pantallas del módulo "Trabaja en Xisti".
// Muestra el texto “Regresar” con doble flecha estilizada (≪ Regresar).

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class WorkAppBar extends StatelessWidget {
  final String title;
  final bool showBack;

  const WorkAppBar({
    super.key,
    required this.title,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Si showBack es true, se muestra el botón de regresar
          if (showBack)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Doble flecha “≪”
                  Text(
                    '≪',
                    style: TextStyle(
                      color: AppTheme.purpleLight,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Texto “Regresar” en morado
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.purpleLight,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(height: 24),
        ],
      ),
    );
  }
}
