import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Abre una URL de forma segura en móvil y web, mostrando SnackBar ante errores.
Future<void> openUrl(BuildContext context, String url) async {
  final uri = Uri.parse(url);

  try {
    if (!await canLaunchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el enlace.')),
        );
      }
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir enlace: $e')),
      );
    }
  }
}
