// Este archivo reproduce el estilo del fondo negro.
// Por otro lado maneja los iconos de las redes sociales.

import 'package:app/ui/drawer_menu/social_panel/xisti_links.dart';
import 'package:app/ui/drawer_menu/social_panel/social_card_parts.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SocialCard extends StatelessWidget {
  final SocialLink link;

  const SocialCard({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    final gradient = brandGradient(link.name);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: AppTheme.border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: ClipRRect(
        borderRadius: AppTheme.border,
        child: Stack(
          children: [
            CardBackground(gradient: gradient),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FollowButton(url: link.url),

                // Iconos grandes y centrados, Facebook, Instagram, TikTok, X, YouTube, etc.
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      link.icon,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                BrandFooter(name: link.name), // Esto es el nombre de la red social debajo.
              ],
            ),
          ],
        ),
      ),
    );
  }
}
