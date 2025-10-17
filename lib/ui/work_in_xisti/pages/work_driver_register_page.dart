// Pantalla de registro de conductor dentro del módulo "Trabaja en Xisti".
// Muestra el progreso de registro de documentos y un botón para continuar.
// Desde aquí el conductor puede acceder a las diferentes etapas del proceso de registro.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/pages/work_basic_info_page.dart';
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
            // Barra superior con el título dinámico según el tipo de vehículo.
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
                    // Lista de pasos del registro con las mismas bolitas en todos los ítems.
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkBasicInfoPage(vehicleType: vehicleType),
                          ),
                        );
                      },
                      child: _buildRegisterItem('Información Básica'),
                    ),
                    _buildRegisterItem('Documento de Identidad'),
                    _buildRegisterItem('Licencia'),
                    _buildRegisterItem('Certificado de buena conducta'),
                    _buildRegisterItem('SOAT'),
                    _buildRegisterItem('Información de vehículo'),

                    const Spacer(),

                    // Botón principal "Continuar"
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

                    // Texto legal informativo al final de la pantalla
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

  // Método que construye cada ítem de la lista del registro.
  // Todas las bolitas tienen el mismo diseño (sin check, sin doble icono).
  static Widget _buildRegisterItem(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Texto del ítem
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: AppTheme.whiteContainer,
                fontSize: 15,
              ),
            ),
          ),

          // Ícono circular (misma bolita para todos)
          Icon(
            Icons.circle_outlined,
            color: AppTheme.whiteContainer.withOpacity(0.4),
            size: 22,
          ),
        ],
      ),
    );
  }
}
