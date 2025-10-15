import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ContactChannelsWidget extends StatelessWidget {
  const ContactChannelsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: AppTheme.border,
        color: AppTheme.inputBackgroundDark,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado del bloque
          Row(
            children: [
              // Ícono principal dentro de un contenedor decorado
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(
                  Icons.contact_phone_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Text(
                  'Canales de Contacto',
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

          // Chat en Vivo
          _buildContactChannel(
            'Chat en Vivo',
            'Conversación instantánea con nuestro equipo',
            Icons.chat_bubble_rounded,
            AppTheme.silver, // Color del icono
            () => _showChatDialog(context),
          ),

          const SizedBox(height: 12),

          // Llamada Telefónica
          _buildContactChannel(
            'Llamada Telefónica',
            '+57 (1) 234-5678 - Disponible 24/7',
            Icons.phone_rounded,
            AppTheme.silver,
            () => _showCallDialog(context),
          ),

          const SizedBox(height: 12),

          // Email de Soporte
          _buildContactChannel(
            'Email de Soporte',
            'soporte@xisti.com - Respuesta en 24h',
            Icons.email_rounded,
            AppTheme.silver,
            () => _showEmailDialog(context),
          ),

          const SizedBox(height: 12),

          // WhatsApp
          _buildContactChannel(
            'WhatsApp',
            '+57 300 123 4567 - Mensajes rápidos',
            Icons.message_rounded,
            AppTheme.silver,
            () => _showWhatsAppDialog(context),
          ),
        ],
      ),
    );
  }

  // Construye un canal de contacto con borde e icono personalizables
  Widget _buildContactChannel(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: AppTheme.border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTheme.border,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Fondo del ícono con tono suave
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: AppTheme.border,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 16),

                // Título y descripción del canal
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppTheme.whiteContainer,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppTheme.lightGreyContainer,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Flecha direccional con opacidad media
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: iconColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Diálogos
  void _showChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.darkDrawerBackground,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.25)),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.18),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(Icons.chat_rounded, color: AppTheme.primaryColor),
              ),
              const SizedBox(width: 12),
              const Text(
                'Chat en Vivo',
                style: TextStyle(color: AppTheme.whiteContainer, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            'El chat en vivo estará disponible próximamente. Mientras tanto, puedes contactarnos por WhatsApp o teléfono.',
            style: TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.blackContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: BorderSide(color: AppTheme.silver.withOpacity(0.25)),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.silver.withOpacity(0.18),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(Icons.phone_rounded, color: AppTheme.silver),
              ),
              const SizedBox(width: 12),
              const Text(
                'Llamar a Soporte',
                style: TextStyle(color: AppTheme.whiteContainer, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            '¿Deseas llamar a nuestra línea de soporte?\n\n+57 (1) 234-5678\n\nDisponible las 24 horas, los 7 días de la semana.',
            style: TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: AppTheme.lightGreyContainer)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.silver,
                foregroundColor: AppTheme.whiteContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Llamar'),
            ),
          ],
        );
      },
    );
  }

  void _showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.25)),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.18),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(Icons.email_rounded, color: AppTheme.primaryColor),
              ),
              const SizedBox(width: 12),
              const Text(
                'Email de Soporte',
                style: TextStyle(color: AppTheme.whiteContainer, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            'Puedes enviarnos un email a:\n\nsoporte@xisti.com\n\nTe responderemos en un máximo de 24 horas.',
            style: TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.blackContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }

  void _showWhatsAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.25)),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.18),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(Icons.message_rounded, color: AppTheme.primaryColor),
              ),
              const SizedBox(width: 12),
              const Text(
                'WhatsApp',
                style: TextStyle(color: AppTheme.whiteContainer, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            'Contáctanos por WhatsApp:\n\n+57 300 123 4567\n\nRespuesta rápida y personalizada.',
            style: TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: AppTheme.lightGreyContainer)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.whiteContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Abrir WhatsApp'),
            ),
          ],
        );
      },
    );
  }
}
