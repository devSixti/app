// Pantalla de selección para conductores dentro del módulo "Trabaja en Xisti".
// Permite elegir el tipo de vehículo con el que el usuario desea trabajar (Carro o Moto).

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_option_button.dart';
import 'package:flutter/material.dart';

/// Pantalla de selección de tipo de conductor: Carro / Moto
class WorkDriverTypePage extends StatelessWidget {
  const WorkDriverTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            const WorkAppBar(title: 'Vas a trabajar con', showBack: true),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    WorkOptionButton(
                      leading: _defaultIconPlaceholder(Icons.directions_car),
                      label: 'Carro',
                      onTap: () {
                        // Por ahora solo navegamos atrás o podrías redirigir a un formulario.
                        Navigator.of(context).pop(); // ejemplo de acción
                      },
                    ),
                    const SizedBox(height: 12),
                    WorkOptionButton(
                      leading: _defaultIconPlaceholder(Icons.motorcycle),
                      label: 'Moto',
                      onTap: () {
                        Navigator.of(context).pop(); // ejemplo de acción
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
