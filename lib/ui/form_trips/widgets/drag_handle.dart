// Este es el archivo que contiene el widget DragHandle (El manejador de arrastre)

import 'package:flutter/material.dart'; 

class DragHandle extends StatelessWidget {
  const DragHandle({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Center( // Centra el manejador de arrastre
      child: Container(
        width: 40,
        height: 5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
