// Pantalla de selección para conductores dentro del módulo "Trabaja en Xisti".
// Permite elegir el tipo de vehículo con el que el usuario desea trabajar (Carro o Moto).

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/pages/work_driver_register_page.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_option_button.dart';
import 'package:flutter/material.dart';

/// Pantalla de selección de tipo de conductor: Carro / Moto.
class WorkDriverTypePage extends StatelessWidget {
  const WorkDriverTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior con el título de la pantalla.
            const WorkAppBar(
              title: 'Vas a trabajar con',
              showBack: true,
            ),

            // Contenido principal.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Botón para seleccionar "Carro".
                    WorkOptionButton(
                      leading: Image.asset(
                        'assets/images/iconografia/dark/car_location.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      label: 'Carro',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkDriverRegisterPage(vehicleType: 'Carro'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Botón para seleccionar "Moto".
                    WorkOptionButton(
                      leading: Image.asset(
                        'assets/images/iconografia/dark/motorbike.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      label: 'Moto',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkDriverRegisterPage(vehicleType: 'Moto'),
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
