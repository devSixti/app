// Archivo principal del Botón de regresar

import 'package:flutter/material.dart';

class BackButton extends StatelessWidget { // Botón de regresar
  final VoidCallback onPressed;
  final String text;
  final double width; // ancho del botón opcional
  final Color? color; // color de fondo opcional
  final TextStyle? style; // estilo del texto opcional
  final Color? textColor; // color del texto opcional

  const BackButton({ // Constructor del botón
    super.key,
    required this.onPressed, // Función que se ejecuta al presionar el botón
    required this.text,
    this.width = 60, // ancho por defecto si no se pasa
    this.color,
    this.style,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) { // Construcción del widget (Osea el botón de regresar)
    final defaultTextStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final appliedStyle = (style ?? defaultTextStyle).copyWith(color: textColor ?? Colors.white);

    return SizedBox(
      width: width, // Usamos el ancho que se pase
      height: 60,   // Altura más grande y proporcional
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color.fromARGB(255, 71, 70, 70), // Color de fondo por defecto
          foregroundColor: textColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14), // Espaciado interno vertical del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Bordes redondeados del botón
            side: const BorderSide(color: Colors.white24), // Borde del botón y color del borde
          ),
        ),
        onPressed: onPressed, // Acción al presionar el botón
        child: Text(
          text,
          style: appliedStyle, // Texto con posible color personalizado
        ),
      ),
    );
  }
}
