// este archivo define un widget DriverModeButton que representa un botón para activar el modo conductor en un drawer.

import 'package:flutter/material.dart';

class DriverModeButton extends StatelessWidget {
  const DriverModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          // Aquí puedes agregar la lógica para activar el modo conductor
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(128, 255, 0, 1),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Modo Conductor',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}