// Este archivo contiene el widget LocationPanel.
// Sirve para mostrar un panel deslizable con los campos de Ubicación inicial
// Ubicación final y un botón "Volver".
// Ajustado para: recibir valores iniciales (opcionales) y devolver las direcciones al cerrar.

import 'package:flutter/material.dart';

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
    // Inicializamos los controladores con los valores recibidos (si los hay)
    _startController = TextEditingController(text: widget.initialStart ?? "");
    _endController = TextEditingController(text: widget.initialEnd ?? "");
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.86, // Ayuda a subir el panel de la pantalla
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1C), // Fondo oscuro
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Input Ubicación inicial
          TextField(
            controller: _startController, // controlador vinculado para mantener el texto
            style: const TextStyle(color: Colors.white, fontSize: 20), // Tamaño de letra
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF2B2B2B),
              hintText: "Ubicación inicial",
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.location_on, color: Color.fromARGB(255, 0, 255, 8)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          const SizedBox(height: 16),

          // Input Ubicación final
          TextField(
            controller: _endController, // controlador vinculado para mantener el texto
            style: const TextStyle(color: Colors.white, fontSize: 20), // Tamaño de letra
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF2B2B2B),
              hintText: "Ubicación final",
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.location_on, color: Color.fromARGB(255, 92, 23, 230)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),

          const Spacer(), // Empuja el botón hacia abajo

          // Botón Volver
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B2B2B),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
              onPressed: () {
                // Devolvemos las direcciones al widget que abrió el panel.
                // Nota: quemar el Navigator.pop aquí no es necesario porque
                // en tu FormTrips pasas una función que ya hace Navigator.pop(...)
                widget.onClose(_startController.text, _endController.text);
              },
              child: const Text(
                "Volver",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
