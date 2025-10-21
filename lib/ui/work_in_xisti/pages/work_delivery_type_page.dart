// Pantalla de selección para repartidores dentro del módulo "Trabaja en Xisti".
// Permite elegir el tipo de repartidor (Repartidor o Repartidor en moto).

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_option_button.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/work_in_xisti/pages/work_delivery_register_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_delivery_bike_register_page.dart';

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
                    // Repartidor en carro
                    WorkOptionButton(
                      leading: Image.asset(
                        'assets/images/iconografia/dark/delivery_card.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      label: 'Repartidor en carro',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkDeliveryRegisterPage(
                              vehicleTypeLabel: 'carro',
                              storageKeySuffix: 'repartidor_carro',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Repartidor en moto
                    WorkOptionButton(
                      leading: Image.asset(
                        'assets/images/iconografia/dark/delivery.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      label: 'Repartidor en moto',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkDeliveryRegisterPage(
                              vehicleTypeLabel: 'moto',
                              storageKeySuffix: 'repartidor_moto',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Repartidor en bicicleta
                    WorkOptionButton(
                      leading: Image.asset(
                        'assets/images/iconografia/dark/delivery.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      label: 'Repartidor en bicicleta',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const WorkDeliveryBikeRegisterPage(
                              storageKeySuffix: 'repartidor_bicicleta',
                            ),
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
