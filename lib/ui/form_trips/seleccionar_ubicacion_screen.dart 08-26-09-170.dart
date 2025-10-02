// Pantalla roja para seleccionar ubicaciones

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class SeleccionarUbicacionScreen extends StatefulWidget {
  final String? inicial;
  final String? finalDestino;

  const SeleccionarUbicacionScreen({
    super.key,
    this.inicial,
    this.finalDestino,
  });

  @override
  State<SeleccionarUbicacionScreen> createState() =>
      _SeleccionarUbicacionScreenState();
}

class _SeleccionarUbicacionScreenState
    extends State<SeleccionarUbicacionScreen> {
  late TextEditingController inicialController;
  late TextEditingController finalController;

  @override
  void initState() {
    super.initState();
    inicialController = TextEditingController(text: widget.inicial);
    finalController = TextEditingController(text: widget.finalDestino);
  }

  @override
  void dispose() {
    inicialController.dispose();
    finalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
        title: const Text("Seleccionar ubicaciones"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: inicialController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Ubicación inicial",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: finalController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Ubicación final",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "inicial": inicialController.text,
                  "final": finalController.text,
                });
              },
              child: const Text("Volver"),
            )
          ],
        ),
      ),
    );
  }
}
