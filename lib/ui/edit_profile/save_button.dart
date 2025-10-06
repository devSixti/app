import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null, // Deshabilitado
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(128, 255, 0, 1), // Verde intenso
          foregroundColor: Colors.black87,
          disabledBackgroundColor: const Color.fromRGBO(128, 255, 0, 1),
          disabledForegroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Guardar cambios',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
