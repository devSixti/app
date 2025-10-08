// Archivo de la sección "¿Deseas trabajar en xisti?"

import 'package:flutter/material.dart';
import '../models/work_option.dart';
import 'package:app/core/theme/app_theme.dart';

class WorkInXistiSection extends StatelessWidget {
  final List<WorkOption> workOptions;

  const WorkInXistiSection({super.key, required this.workOptions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(
            0xFF232323,
          ), // Color del contenedor completo de abajo.
          borderRadius: AppTheme.border,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Color.fromRGBO(255, 255, 255, 1).withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título principal
            const Text(
              '¿Deseas trabajar en xisti?',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: AppTheme.mediumSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            // Subtítulo
            Text(
              'Regístrate y comienza hoy mismo',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: AppTheme.mediumSize,
              ),
            ),
            const SizedBox(height: 16),
            // Lista de opciones de trabajo
            ...workOptions.map((option) => _buildWorkOption(option)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkOption(WorkOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        borderRadius: AppTheme.border,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppTheme.border,
        child: InkWell(
          onTap: () {
            // Aquí se puede agregar navegación específica para cada opción
          },
          borderRadius: AppTheme.border,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Row(
              children: [
                // Icono XI (logo de Xisti)
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: AppTheme.border,
                  ),
                  child: const Center(
                    child: Text(
                      'XI',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: AppTheme.mediumSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                // Información de la opción
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: AppTheme.mediumSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        option.subtitle,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: AppTheme.smallSize,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade600,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
