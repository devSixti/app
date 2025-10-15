import 'package:app/ui/pages_drawer/help/help_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class FaqSupportWidget extends StatelessWidget {
  const FaqSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.inputBackgroundDark, AppTheme.darkGreyContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppTheme.border,
        border: Border.all(color: AppTheme.silver.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.blackContainer.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado principal de la sección FAQ
          Row(
            children: [
              // Ícono principal dentro de un contenedor decorado
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(
                    0.3,
                  ), // Fondo semitransparente del cuadro
                  borderRadius: AppTheme.border,
                  border: Border.all(
                    color: AppTheme.silver.withOpacity(
                      0.3,
                    ), // Borde con leve opacidad
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.quiz_rounded,
                  color: AppTheme.primaryColor, // Color del ícono principal
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Preguntas Frecuentes',
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

          // Pregunta 1
          _buildFaqItem(
            '¿Cómo contactar a mi conductor?',
            'Durante el viaje puedes usar los botones de llamada o mensaje.',
            Icons.phone_rounded,
            AppTheme.silver, // Color del borde
            AppTheme.silver, // Color del ícono
          ),

          const SizedBox(height: 12),

          // Pregunta 2
          _buildFaqItem(
            '¿Qué hacer si mi viaje se cancela?',
            'El sistema buscará automáticamente otro conductor disponible.',
            Icons.cancel_rounded,
            AppTheme.silver,
            AppTheme.silver,
          ),

          const SizedBox(height: 12),

          // Pregunta 3
          _buildFaqItem(
            '¿Cómo cambiar mi método de pago?',
            'Ve a Billetera > Métodos de pago para actualizar tus opciones.',
            Icons.payment_rounded,
            AppTheme.silver,
            AppTheme.silver,
          ),

          const SizedBox(height: 16),

          // Botón inferior: "Ver todas las preguntas"
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.blackContainer.withOpacity(0.2),
              borderRadius: AppTheme.border,
              border: Border.all(
                color: AppTheme.silver.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: AppTheme.border,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpPage()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_center_rounded,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Ver todas las preguntas',
                        style: TextStyle(
                          color: AppTheme.inputBackgroundLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Ítem individual de pregunta frecuente
  /// Ahora con colores separados: uno para el borde y otro para el ícono.
  Widget _buildFaqItem(
    String question,
    String answer,
    IconData icon,
    Color borderColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.2),
        borderRadius: AppTheme.border,
        border: Border.all(
          color: borderColor.withOpacity(0.3), // Borde visible e independiente
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila de icono + pregunta
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2), // Fondo del ícono
                  borderRadius: AppTheme.border,
                  border: Border.all(
                    color: iconColor.withOpacity(
                      0.4,
                    ), // Borde decorativo del ícono
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 16,
                ), // Ícono con color independiente
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Respuesta (alineada con la pregunta)
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: Text(
              answer,
              style: const TextStyle(
                color: AppTheme.lightGreyContainer,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
