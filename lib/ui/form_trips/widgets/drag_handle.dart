// Este es el archivo que contiene el widget DragHandle (El manejador de arrastre)

import 'package:flutter/material.dart'; 

class DragHandle extends StatelessWidget {
  const DragHandle({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Center( // Centra el manejador de arrastre
      child: Container(
        width: 80, // Ancho del manejador de arrastre
        height: 7, // Alto del manejador de arrastre
        margin: const EdgeInsets.only(bottom: 16), // Margen inferior para separarlo del contenido
        decoration: BoxDecoration(
          color: Colors.grey[600], // Color del manejador de arrastre y su sombra
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
      ),
    );
  }
}
