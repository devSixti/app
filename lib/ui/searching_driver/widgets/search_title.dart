// Componente del título principal de búsqueda

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SearchTitle extends StatelessWidget {
  const SearchTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Buscando conductores para tu\nsolicitud…',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: AppTheme.mediumSize,
        fontWeight: FontWeight.bold,
        color: AppTheme.whiteContainer,
        height: 1.3,
      ),
    );
  }
}
