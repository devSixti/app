// Este archivo contiene el widget LocationPanel.
// Sirve para mostrar un panel deslizable con los campos de Ubicación inicial
// Ubicación final y un botón "Volver".
// Ajustado para: recibir valores iniciales (opcionales) y devolver las direcciones al cerrar.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/form_trips/widgets/custom_back_button.dart';

class LocationPanel extends StatefulWidget {
  // Valores iniciales opcionales (pueden ser null)
  final String? initialStart;
  final String? initialEnd;

  // onClose devuelve ambas direcciones al widget que abrió el panel
  final void Function(String start, String end) onClose;

  const LocationPanel({
    super.key,
    required this.onClose,
    this.initialStart,
    this.initialEnd,
  });

  @override
  State<LocationPanel> createState() => _LocationPanelState();
}

class _LocationPanelState extends State<LocationPanel> {
  late TextEditingController _startController;
  late TextEditingController _endController;

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController(text: widget.initialStart ?? "");
    _endController = TextEditingController(text: widget.initialEnd ?? "");
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void _handleMainBackButton() {
    widget.onClose(_startController.text, _endController.text);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.86, // altura inicial
      minChildSize: 0.5, // altura mínima al arrastrar hacia abajo
      maxChildSize: 0.95, // altura máxima al arrastrar hacia arriba
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C1C),
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input Ubicación inicial
                TextField(
                  controller: _startController,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: AppTheme.mediumSize,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF2B2B2B),
                    hintText: "Ubicación inicial",
                    hintStyle: const TextStyle(color:   Colors.white54),
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: AppTheme.primaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: AppTheme.border,
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Input Ubicación final
                TextField(
                  controller: _endController,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: AppTheme.mediumSize,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF2B2B2B),
                    hintText: "Ubicación final",
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: AppTheme.purpleColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: AppTheme.border,
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 480), // Altura de la opcion "Volver"
                // Botón Volver
                Center(
                  child: CustomBackButton(
                    onPressed: _handleMainBackButton,
                    text: "Volver",
                    width: MediaQuery.of(context).size.width * 0.5,
                    textColor: AppTheme.lightPrimaryContainer
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}