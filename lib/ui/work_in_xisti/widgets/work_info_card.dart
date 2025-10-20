// Este widget representa la tarjeta informativa de la pantalla inicial.
// Muestra el título principal, una lista de beneficios y una imagen ilustrativa a la derecha.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class WorkInfoCard extends StatelessWidget {
  final String title;
  final List<String> bullets;

  const WorkInfoCard({
    super.key,
    required this.title,
    required this.bullets, required TextAlign textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Columna izquierda: título centrado y lista de bullets
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // centramos el título
              children: [
                // Título centrado horizontalmente
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),

                // Lista de beneficios alineados a la izquierda
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bullets
                        .map(
                          (b) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppTheme.primaryColor,
                                  size: 20,
                                ),
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
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Imagen a la derecha centrada verticalmente
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/Citydriver-rafiki.png', // Imagen
                width: 300,
                height:200,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
