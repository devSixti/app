// Este widget representa la tarjeta informativa de la pantalla inicial.
// Muestra el título principal, una lista de beneficios y un espacio para una imagen ilustrativa.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

/// Tarjeta informativa que aparece en la primera pantalla.
/// Recibe título y una lista de bullets. Se puede ampliar para aceptar una imagen.
class WorkInfoCard extends StatelessWidget {
  final String title;
  final List<String> bullets;

  const WorkInfoCard({
    super.key,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Fondo oscuro para destacar sobre darkScaffold
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Izquierda: lista de bullets
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                ...bullets.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              b,
                              style: TextStyle(
                                color: AppTheme.whiteContainer,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Derecha: placeholder para imagen (fácil de cambiar por un Image.asset o Svg)
             Expanded(
            flex: 3,
             child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                'assets/images/Citydriver-rafiki.png',
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
