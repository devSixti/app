// Pantalla de selección para repartidores dentro del módulo "Trabaja en Xisti".
// Permite elegir el tipo de repartidor (Repartidor o Repartidor en moto).

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_option_button.dart';
import 'package:flutter/material.dart';

/// Pantalla de selección de tipo de repartidor: Repartidor / Repartidor en moto.
class WorkDeliveryTypePage extends StatelessWidget {
  const WorkDeliveryTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior personalizada con texto “Vas a trabajar de:”.
            const WorkAppBar(
              title: 'Vas a trabajar de:',
              showBack: true,
            ),

            // Contenido principal.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Botón para seleccionar "Repartidor".
                    WorkOptionButton(
                      // Ícono real del repartidor.
                      leading: Image.asset(
                        '/Users/macxisti/Desktop/app/assets/images/iconografia/dark/delivery_card.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      label: 'Repartidor en carro',
                      onTap: () {
                        // Aquí podrías redirigir a un formulario o acción correspondiente.
                        Navigator.of(context).pop();
                      },
                    ),

                    const SizedBox(height: 16),

                    // Botón para seleccionar "Repartidor en moto".
                    WorkOptionButton(
                      // Ícono real del repartidor en moto.
                      leading: Image.asset(
                        '/Users/macxisti/Desktop/app/assets/images/iconografia/dark/delivery.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      label: 'Repartidor en moto',
                      onTap: () {
                        Navigator.of(context).pop();
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
