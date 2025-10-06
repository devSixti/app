// Archivo de buscar conductor

import 'package:flutter/material.dart';

class SearchDriverButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SearchDriverButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // altura más grande
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 38, 255, 0), // Color de fondo verde
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 48), // padding más ajustado
        ),
        onPressed: onPressed,
        child: const Text(
          "Buscar\nconductor",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17, // texto más grande
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



