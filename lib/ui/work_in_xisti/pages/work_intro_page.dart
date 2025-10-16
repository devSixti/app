// Esta pantalla muestra la introducción al módulo "Trabaja en Xisti".
// Contiene la información principal, beneficios y las opciones iniciales
// para registrarse como Conductor o Repartidor.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_info_card.dart';
import 'package:app/ui/work_in_xisti/widgets/work_option_button.dart';
import 'package:flutter/material.dart';
import 'work_driver_type_page.dart';
import 'work_delivery_type_page.dart';

/// Primera pantalla: "Trabaja en Xisti"
/// Muestra info y opciones: Conductor / Repartidor
class WorkIntroPage extends StatelessWidget {
  const WorkIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra superior personalizada
        const WorkAppBar(
          title: 'Trabaja en Xisti',
          showBack: true,
        ),

        // Contenido principal en scroll
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                // Tarjeta informativa (imagen + bullets)
                const WorkInfoCard(
                  title: 'Trabaja en Xisti',
                  bullets: [
                    'Tus precios',
                    'Ordena tu tiempo',
                    'La menor tasa de pago por servicio de Colombia',
                  ],
                  // Icono o imagen opcional: se puede reemplazar por un Image.asset/SVG
                  // Por defecto usamos un Container ilustrativo.
                ),

                const SizedBox(height: 24),

                // Título para continuar registro
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Continuar registro como:',
                    style: TextStyle(
                      color: AppTheme.whiteContainer,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Botón Conductor -> al seleccionar abre la pantalla de tipos de conductor
                WorkOptionButton(
                  // icon: Icon(Icons.directions_car, size: 36), // ejemplo
                  leading: _defaultIconPlaceholder(Icons.directions_car),
                  label: 'Conductor',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const WorkDriverTypePage()),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Botón Repartidor -> abre pantalla de tipos de repartidor
                WorkOptionButton(
                  leading: _defaultIconPlaceholder(Icons.delivery_dining),
                  label: 'Repartidor',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const WorkDeliveryTypePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Helper que devuelve un contenedor con icono para que sea fácil reemplazarlo luego.
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
