// Archivo que contiene partes comunes para las cards de redes sociales.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'open_url.dart';

class CardBackground extends StatelessWidget {
  final LinearGradient gradient;
  const CardBackground({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(gradient: gradient),
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  final String url;
  const FollowButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () => openUrl(context, url),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white.withOpacity(0.08),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text('Seguir'),
        ),
      ),
    );
  }
}

class BrandFooter extends StatelessWidget {
  final String name;
  const BrandFooter({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppTheme.mediumSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

LinearGradient brandGradient(String name) {
  switch (name.toLowerCase()) {
    case 'instagram':
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
      return const LinearGradient(
        colors: [
          Colors.black,
          Colors.black,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'facebook':
      return LinearGradient(
        colors: [
          const Color(0xFF1877F2),
          const Color(0xFF1877F2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'youtube':
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
      return const LinearGradient(
        colors: [
          Colors.white10,
          Colors.white10,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'linkedin':
      return LinearGradient(
        colors: [
          const Color(0xFF0A66C2),
          const Color(0xFF0A66C2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'telegram':
      return LinearGradient(
        colors: [
          const Color(0xFF229ED9),
          const Color(0xFF229ED9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    default:
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
