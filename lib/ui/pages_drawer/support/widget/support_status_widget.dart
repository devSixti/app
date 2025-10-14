import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SupportStatusWidget extends StatelessWidget {
  const SupportStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Colores personalizables
    final Color borderColor = AppTheme.silver.withOpacity(0.3); // Color del borde principal
    final Color iconColor = AppTheme.primaryColor; // Color del icono superior
    final Color gradientStart = AppTheme.inputBackgroundDark.withOpacity(0.3); // Color inicial del degradado
    final Color gradientEnd = AppTheme.inputBackgroundDark; // Color final del degradado
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        // Fondo degradado
        gradient: LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),

        // Borde visible y elegante
        border: Border.all(
          color: borderColor, // Color del borde
          width: 1,
        ),
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
                decoration: BoxDecoration(
                  // Degradado interno del icono
                  gradient: LinearGradient(
                    colors: [
                      iconColor.withOpacity(0.4),
                      iconColor.withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
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
                  borderColor: AppTheme.silver.withOpacity(0.4), // Borde del cuadro
                  iconColor: AppTheme.primaryColor, // Color del ícono
                  valueColor: AppTheme.primaryColor, // Color del texto del valor
                ),
              ),
              const SizedBox(width: 12),

              // Estado "Tiempo de Respuesta"
              Expanded(
                child: _buildStatusCard(
                  title: 'Tiempo de Respuesta',
                  value: '< 5 minutos',
                  icon: Icons.schedule_rounded,
                  borderColor: AppTheme.silver.withOpacity(0.3), // Borde del cuadro
                  iconColor: AppTheme.primaryColor, // Color del ícono
                  valueColor: AppTheme.primaryColor, // Color del valor
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
    required Color borderColor, // Color del borde del cuadro
    required Color iconColor, // Color del ícono
    required Color valueColor, // Color del valor
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.2), // Fondo semitransparente
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor, // Color del borde de la tarjeta
          width: 1,
        ),
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
