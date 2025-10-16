// Este widget define una barra superior personalizada (AppBar) reutilizable
// para todas las pantallas del módulo "Trabaja en Xisti".
// Incluye el título y un botón opcional para regresar.

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// AppBar sencillo reutilizable para las páginas del módulo.
/// showBack controla si se muestra botón de regresar.
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          if (showBack)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back,
                color: AppTheme.whiteContainer,
                size: 22,
              ),
            )
          else
            const SizedBox(width: 22),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: AppTheme.whiteContainer,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
