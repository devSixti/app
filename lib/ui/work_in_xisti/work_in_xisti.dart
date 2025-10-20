// Esta pantalla muestra la introducción al módulo "Trabaja en Xisti".
// Contiene la información principal, beneficios y las opciones iniciales
// para registrarse como Conductor o Repartidor.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_info_card.dart';
import 'package:app/ui/work_in_xisti/widgets/work_option_button.dart';
import 'package:flutter/material.dart';
import 'pages/work_driver_type_page.dart';
import 'pages/work_delivery_type_page.dart';

/// Primera pantalla: "Trabaja en Xisti"
/// Muestra info y opciones: Conductor / Repartidor.
class WorkInXisti extends StatelessWidget {
  const WorkInXisti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior personalizada con texto “Regresar”.
            const WorkAppBar(
              title: 'Regresar',
              showBack: true,
            ),

            // Contenido principal desplazable.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Tarjeta informativa con título centrado y lista de beneficios.
                    const WorkInfoCard(
                      textAlign: TextAlign.center,
                      title: 'Trabaja en Xisti',
                      bullets: [
                        'Tus precios.',
                        'Ordena tu tiempo.',
                        'La menor tasa de pago por servicio de Colombia.',
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Subtítulo centrado que indica el paso siguiente.
                    Text(
                      'Continuar registro como:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.whiteContainer,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Botón para acceder a la vista de conductor.
                    WorkOptionButton(
                      // Imagen real del icono de conductor.
                      leading: Image.asset(
                        'assets/images/iconografia/dark/car_tool.png',
                        width: 42,
                        height: 42,
                        fit: BoxFit.contain,
                      ),
                      label: 'Conductor',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkDriverTypePage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Botón para acceder a la vista de repartidor.
                    WorkOptionButton(
                      leading: Image.asset(
                        'assets/images/iconografia/dark/delivery_fast.png',
                        width: 42,
                        height: 42,
                        fit: BoxFit.contain,
                      ),
                      label: 'Repartidor',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkDeliveryTypePage(),
                          ),
                        );
                      },
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
}
