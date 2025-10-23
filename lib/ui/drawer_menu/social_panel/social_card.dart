// Esta card reproduce el estilo solicitado: fondo negro, esquinas redondeadas,
// sombra suave y un degradado/halo según la marca.

import 'package:app/ui/drawer_menu/social_panel/open_url.dart';
import 'package:app/ui/drawer_menu/social_panel/social_link.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SocialCard extends StatelessWidget {
  final SocialLink link;

  const SocialCard({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    final gradient = _brandGradient(link.name);
    _brandPrimary(link.name);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: AppTheme.border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: ClipRRect(
        borderRadius: AppTheme.border,
        child: Stack(
          children: [
            // Fondo con degradado de marca sutil
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Botón superior "Seguir"
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () => openUrl(context, link.url),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Seguir'),
                    ),
                  ),
                ),

                // Hero de marca (sin imagen), con ícono grande en blanco
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      link.icon,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),

                // Pie con nombre de la red
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      
                      const SizedBox(width: 8),
                      Text(
                        link.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppTheme.mediumSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 // Devuelve un degradado asociado a la marca
LinearGradient _brandGradient(String name) {
  switch (name.toLowerCase()) {
    case 'instagram':
      // Degradado oficial Instagram
      return const LinearGradient(
        colors: [
          Color(0xFFF58529),
          Color(0xFFDD2A7B),
          Color(0xFF8134AF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

    case 'tiktok':
      // Negro principal con acentos fucsia y turquesa
      return const LinearGradient(
        colors: [
          Colors.black,
          Colors.black, 
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

    case 'facebook':
      // Azul principal con toque blanco
      return LinearGradient(
        colors: [
          const Color(0xFF1877F2),
          const Color(0xFF1877F2),
          
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

    case 'youtube':
      // Rojo característico con degradado a blanco
      return LinearGradient(
        colors: [
          const Color(0xFFFF0000),
          const Color(0xFFFF0000),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

    case 'x':
    case 'x (twitter)':
      // Fondo negro con ligero gris
      return const LinearGradient(
        colors: [
          Colors.white10,
          Colors.white10,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

    case 'linkedin':
      // Azul corporativo LinkedIn
      return LinearGradient(
        colors: [
        
          const Color(0xFF0A66C2),
          const Color(0xFF0A66C2),
          
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

    case 'telegram':
      // Azul celeste con blanco sutil
      return LinearGradient(
        colors: [
          const Color(0xFF229ED9),
          const Color(0xFF229ED9),
        
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

    default:
      // Para otras marcas o página web (Xisti)
      return LinearGradient(
        colors: [
          AppTheme.primaryColor.withOpacity(0.3),
          Colors.white.withOpacity(0.1),
          AppTheme.primaryColor.withOpacity(0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  }
}

  // Color primario por marca para pintar el ícono
  Color _brandPrimary(String name) {
    switch (name.toLowerCase()) {
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'instagram':
        return const Color(0xFF833AB4);
      case 'tiktok':
        return const Color(0xFFEE1D52);
      case 'telegram':
        return const Color(0xFF229ED9);
      case 'linkedin':
        return const Color(0xFF0A66C2);
      case 'youtube':
        return const Color(0xFFFF0000);
      case 'x (twitter)':
      case 'x':
        return Colors.white;
      default:
        return Colors.white;
    }
  }
}
