import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SupportStatusWidget extends StatelessWidget {
  const SupportStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Colores personalizables

    final Color iconColor = AppTheme.purpleColor; // Color del icono superior
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppTheme.darkScaffold,
        borderRadius: AppTheme.border, 
      ),

      // Contenido interno
      child: Column(
        children: [
          // Encabezado
          Row(
            children: [
              // Icono dentro de un contenedor decorativo
              Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.support_rounded,
                  color: iconColor, // Color del ícono principal
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Título principal
              const Expanded(
                child: Text(
                  'Estado del Soporte',
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Tarjetas de estado
          Row(
            children: [
              // Estado "En línea"
              Expanded(
                child: _buildStatusCard(
                  title: 'En Línea',
                  value: 'Disponible 24/7',
                  icon: Icons.circle,

                  iconColor: AppTheme.purpleColor, // Color del ícono
                  valueColor: AppTheme.purpleColor, // Color del texto del valor
                ),
              ),
              const SizedBox(width: 12),

              // Estado "Tiempo de Respuesta"
              Expanded(
                child: _buildStatusCard(
                  title: 'Tiempo de Respuesta',
                  value: '< 5 minutos',
                  icon: Icons.schedule_rounded,
                  iconColor: AppTheme.purpleColor, // Color del ícono
                  valueColor: AppTheme.purpleColor, // Color del valor
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget de tarjeta de estado individual
  Widget _buildStatusCard({
    required String title,
    required String value,
    required IconData icon,

    // Colores independientes para cada elemento
    required Color iconColor, // Color del ícono
    required Color valueColor, // Color del valor
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.2), // Fondo semitransparente
        borderRadius: AppTheme.border,
      ),
      child: Column(
        children: [
          // Ícono del estado
          Icon(icon, color: iconColor, size: 20),

          const SizedBox(height: 8),

          // Título descriptivo
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.lightGreyContainer,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // Valor o estado actual
          Text(
            value,
            style: TextStyle(
              color: valueColor, // Color del texto del valor
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
