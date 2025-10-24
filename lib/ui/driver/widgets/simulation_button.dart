import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SimulationButton extends StatelessWidget {
  final VoidCallback onSimulate;

  const SimulationButton({super.key, required this.onSimulate});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Simular pedido',
      onPressed: onSimulate,
      icon: const Icon(Icons.notifications_active, color: AppTheme.whiteContainer),
    );
  }
}
