// Pantalla de registro de conductor dentro del módulo "Trabaja en Xisti".
// Muestra el progreso de registro de documentos y un botón para continuar.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:flutter/material.dart';

class WorkDriverRegisterPage extends StatelessWidget {
  final String vehicleType; // Carro o Moto

  const WorkDriverRegisterPage({
    super.key,
    required this.vehicleType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior con título dinámico.
            WorkAppBar(
              title: 'Registro Conductor ($vehicleType)',
              showBack: true,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lista de pasos del registro.
                    _buildRegisterItem('Información Básica', true, false),
                    _buildRegisterItem('Documento de Identidad', false, false),
                    _buildRegisterItem('Licencia', false, false),
                    _buildRegisterItem('Certificado de buena conducta', true, true),
                    _buildRegisterItem('SOAT', true, true),
                    _buildRegisterItem('Información de vehículo', false, false),

                    const Spacer(),

                    // Botón Continuar
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Continuar',
                          style: TextStyle(
                            color: AppTheme.blackContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Texto legal
                    Transform.translate(
                      offset: const Offset(0, -35),
                      child: Text(
                        'Al presionar “continuar”, acepto los Términos y condiciones de Xisti, además acepto el procesamiento y transferencia de datos personales según nuestra Política de privacidad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.greyTextColor,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construye cada ítem de la lista del registro.
  static Widget _buildRegisterItem(String title, bool complete, bool doubleIcon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: BorderRadius.circular(8),
      ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppTheme.whiteContainer,
                  fontSize: 15,
                ),
              ),
          ),
          if (doubleIcon) ...[
            Icon(Icons.verified_rounded, color: AppTheme.successColor, size: 20),
            const SizedBox(width: 8),
          ],
          Icon(
            complete ? Icons.check_circle_outline_rounded : Icons.circle_outlined,
            color: complete
                ? AppTheme.purpleColor
                : AppTheme.whiteContainer.withOpacity(0.4),
            size: 22,
          ),
        ],
      ),
    );
  }
}
