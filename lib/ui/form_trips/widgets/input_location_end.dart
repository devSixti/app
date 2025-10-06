// Este archivo es para la ubicacion final del viaje.

import 'package:flutter/material.dart';

class InputLocationEnd extends StatelessWidget {
  const InputLocationEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Espaciado interno del contenedor (padding horizontal y vertical)
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

      // Decoración del contenedor: color de fondo y bordes redondeados
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer, // Usa un color del tema
        borderRadius: BorderRadius.circular(12), // Bordes redondeados de 12px
      ),

      // Contenido interno del contenedor
      child: Row(
        children: [
          // Ícono de ubicación
          const Icon(Icons.location_on, color: Color.fromRGBO(96, 43, 201, 1)),

          // Separación horizontal entre el ícono y el texto
          const SizedBox(width: 8),

          // El texto se expande para ocupar todo el espacio restante de la fila
          Expanded(
            child: Text(
              "Ubicación final", // Texto mostrado dentro del campo
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Color.fromRGBO(255, 255, 255, 1) // Color del texto en blanco original de xisti.
                  ),
            ),
          ),
        ],
      ),
    );
  }
}