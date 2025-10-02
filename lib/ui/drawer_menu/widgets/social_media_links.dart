//  este archivo define un widget SocialMediaLinks que muestra iconos de redes sociales y un texto en un drawer. 

import 'package:flutter/material.dart';

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
                  // Abrir Facebook
                },
              ),
              _buildSocialIcon(
                icon: Icons.tiktok,
                onTap: () {
                  // Abrir TikTok
                },
              ),
              _buildSocialIcon(
                icon: Icons.camera_alt, // Instagram icon
                onTap: () {
                  // Abrir Instagram
                },
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Texto de redes sociales
          const Text(
            'Síguenos en nuestras redes sociales',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
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
          // ignore: deprecated_member_use
          color: Colors.white.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Colors.white70,
          size: 20,
        ),
      ),
    );
  }
}