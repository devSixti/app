// Este archivo actúa como punto de entrada del módulo "Trabaja en Xisti".
// Desde aquí se inicia la navegación hacia las diferentes pantallas del flujo
// (intro, tipo de conductor, tipo de repartidor).

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'pages/work_intro_page.dart';

/// Entry point para la funcionalidad "Trabaja en Xisti".
/// Mantén este archivo como la "pantalla raíz" del módulo.
/// Desde aquí se navega a las demás pantallas.
class WorkInXisti extends StatefulWidget {
  const WorkInXisti({super.key});

  @override
  State<WorkInXisti> createState() => _WorkInXistiState();
}

class _WorkInXistiState extends State<WorkInXisti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos el color darkScaffold del AppTheme asumiendo modo oscuro.
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: const WorkIntroPage(),
      ),
    );
  }
}
