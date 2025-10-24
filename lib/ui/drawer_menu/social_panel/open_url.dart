// Este archivo abre un enlace de forma robusta en emuladores y dispositivos reales.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(BuildContext context, String url) async {
  // 1) Normalizar URL: agregar esquema si falta.
  final normalized = _ensureHttpScheme(url.trim());
  final uri = Uri.parse(normalized);

  // 2) Intentar abrir con distintos modos, con mensajes útiles.
  try {
    // Primer intento: app externa (navegador del sistema)
    final openedExternal = await _tryLaunch(uri, LaunchMode.externalApplication);
    if (openedExternal) return;

    // Segundo intento: modo por defecto de la plataforma (puede abrir en vista integrada)
    final openedDefault = await _tryLaunch(uri, LaunchMode.platformDefault);
    if (openedDefault) return; 

    // ignore: use_build_context_synchronously
    _showOpenError(context, uri);
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir el enlace: $e')),
      );
    }
  }
}

// Intenta lanzar la URL con el modo indicado. Devuelve true si logra abrir.
Future<bool> _tryLaunch(Uri uri, LaunchMode mode) async {
  // En web, LaunchMode es ignorado y se abre en nueva pestaña.
  // canLaunchUrl puede devolver false en entornos sin handler; aún así probamos directamente.
  try {
    final ok = await launchUrl(uri, mode: mode);
    return ok;
  } catch (_) {
    return false;
  }
}

// Asegura que la URL tenga esquema http/https.
String _ensureHttpScheme(String value) {
  final lower = value.toLowerCase();
  if (lower.startsWith('http://') || lower.startsWith('https://')) return value;
  return 'https://$value';
}

void _showOpenError(BuildContext context, Uri uri) {
  if (!context.mounted) return;

  // Mensaje específico para emuladores Android sin navegador instalado.
  final hint = (!kIsWeb && Theme.of(context).platform == TargetPlatform.android)
      ? ' Verifica que el emulador tenga un navegador instalado (p. ej., Chrome)\n o usa un dispositivo físico.'
      : '';

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('No se pudo abrir: ${uri.toString()}.$hint'),
    ),
  );
}
