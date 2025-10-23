// Este archivo define el tile reutilizable que muestra cada red social.
// Si `link.assetPath` viene con una ruta válida se usa esa imagen (logo original);
// si no, se muestra el ícono de fallback.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'social_link.dart';
import 'open_url.dart';

class SocialItemTile extends StatelessWidget {
  final SocialLink link;

  const SocialItemTile({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 1),
          width: 1.5,
        ),
        borderRadius: AppTheme.border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTheme.border,
          onTap: () => openUrl(context, link.url),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Avatar circular: intenta mostrar logo original si existe
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: link.assetPath != null
                      ? Image.asset(
                          link.assetPath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            link.icon,
                            size: 18,
                            color: AppTheme.inputBackgroundLight,
                          ),
                        )
                      : Icon(
                          link.icon,
                          size: 18,
                          color: AppTheme.inputBackgroundLight,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    link.name,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: AppTheme.mediumSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
