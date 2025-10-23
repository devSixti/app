// Este archivo define el modelo de datos para cada item del panel social.
// Incluye tanto un ícono (fallback) como una ruta a imagen local (assetPath)
// para permitir usar los logotipos originales de cada red.

import 'package:flutter/material.dart';

class SocialLink {
  // Ruta a la imagen local del logotipo (si existe en assets). Ej: assets/images/facebook.png
  // Si es null, la UI usará el ícono por defecto.
  final String? assetPath;

  // Ícono de fallback (Material o similar) cuando no hay imagen disponible.
  final IconData icon;

  // Nombre visible de la red social.
  final String name;

  // URL absoluta a abrir cuando se toca el item.
  final String url;

  const SocialLink({
    this.assetPath,
    required this.icon,
    required this.name,
    required this.url,
  });
}
