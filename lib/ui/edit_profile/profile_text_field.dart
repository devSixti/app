// Archivo para editar la parte de las opciones para escribir en el campo del "Editar"

import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final String? hintText;
  final bool enabled;
  final IconData? icon;
  final int? maxLength;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.initialValue,
    this.hintText,
    this.enabled = true,
    this.icon,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      maxLength: maxLength,
      style: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 18,
        height: 0.1, // hace que el cursor sea más corto visualmente
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400], fontSize: 18),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        suffixIcon: icon != null ? Icon(icon, color: Colors.grey[400]) : null,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        counterText: maxLength != null ? null : '',
      ),
      cursorColor: Color.fromRGBO(255, 255, 255, 1), // Color del cursor para escribir
      cursorWidth: 1.2, // más delgado
    );
  }
}
