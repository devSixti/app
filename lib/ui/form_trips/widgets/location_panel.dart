// Este archivo contiene el widget LocationPanel.
// Sirve para mostrar un panel deslizable con los campos de Ubicación inicial,
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

  Widget _buildLocationField({
    required TextEditingController controller,
    required String hintText,
    required String iconPath, required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B),
        borderRadius: AppTheme.border,
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 28, // tamaño ajustable
            height: 28, // tamaño ajustable
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: false,
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: AppTheme.mediumSize,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white54),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.86,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
                _buildLocationField(
                  controller: _startController,
                  hintText: "Ubicación inicial",
                  iconPath: 'assets/images/pin_verde.png',
                  iconColor: AppTheme.primaryColor,
                ),
                const SizedBox(height: 16),

                // Input Ubicación final
                _buildLocationField(
                  controller: _endController,
                  hintText: "Ubicación final",
                  iconPath: 'assets/images/pin_morado.png',
                  iconColor: AppTheme.purpleColor,
                ),

                const SizedBox(height: 480), // Altura de la opción "Volver"

                // Botón Volver
                Center(
                  child: CustomBackButton(
                    onPressed: _handleMainBackButton,
                    text: "Volver",
                    width: MediaQuery.of(context).size.width * 0.5,
                    textColor: AppTheme.lightPrimaryContainer,
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
