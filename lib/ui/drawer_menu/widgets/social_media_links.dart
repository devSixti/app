// Este archivo define un widget SocialMediaLinks que muestra iconos de redes sociales y un texto en un drawer.

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import principal para usar launchUrl y LaunchMode

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Fila de iconos de redes sociales
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialIcon(
                icon: Icons.facebook,
                onTap: () {
                  _openUrl(
                    context,
                    "https://www.facebook.com/xistiapp?locale=es_LA",
                  ); // Abrir facebook
                },
              ),
              _buildSocialIcon(
                icon: Icons.tiktok,
                onTap: () {
                  _openUrl(
                    context,
                    "https://www.tiktok.com/@xistiapp",
                  ); // Abrir TikTok
                },
              ),
              _buildSocialIcon(
                icon: Icons.camera_alt, // Instagram icon
                onTap: () {
                  _openUrl(
                    context,
                    "https://www.instagram.com/xistiapp/",
                  ); // Abrir Instagram
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Texto de redes sociales
          const Text(
            'Síguenos en nuestras redes sociales',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: AppTheme.smallSize,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Uso de color con transparencia para el fondo del ícono
          // ignore: deprecated_member_use
          color: Colors.white.withValues(alpha: 0.1),
        ),
        child: Icon(
          icon,
          color: Color.fromRGBO(
            255,
            255,
            255,
            1,
          ), // Color de los iconos de (Ig, fb y Tik Tok)
          size: 20,
        ),
      ),
    );
  }
}

// Implementación segura para abrir un link tanto en web como en móvil
Future<void> _openUrl(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);

  try {
    // Se verifica si el enlace puede ser abierto
    if (!await canLaunchUrl(uri)) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el enlace.")),
      );
      return;
    }

    // Se usa launchUrl con LaunchMode.externalApplication para móvil
    // En web automáticamente abre una nueva pestaña
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    // Si ocurre un error, se muestra un mensaje en pantalla
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Error al abrir enlace: $e")));
  }
}
