// Pantalla de selección para repartidores dentro del módulo "Trabaja en Xisti".
// Permite elegir el tipo de repartidor (Repartidor o Repartidor en moto).

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_option_button.dart';
import 'package:flutter/material.dart';

/// Pantalla de selección de tipo de repartidor: Repartidor / Repartidor en moto
class WorkDeliveryTypePage extends StatelessWidget {
  const WorkDeliveryTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            const WorkAppBar(title: 'Vas a trabajar de:', showBack: true),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    WorkOptionButton(
                      leading: _defaultIconPlaceholder(Icons.local_shipping),
                      label: 'Repartidor',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 12),
                    WorkOptionButton(
                      leading: _defaultIconPlaceholder(Icons.delivery_dining),
                      label: 'Repartidor en moto',
                      onTap: () => Navigator.of(context).pop(),
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

  static Widget _defaultIconPlaceholder(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppTheme.inputBackgroundDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(icon, size: 28, color: AppTheme.whiteContainer),
      ),
    );
  }
}
