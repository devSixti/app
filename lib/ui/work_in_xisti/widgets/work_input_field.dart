// Widget reutilizable para los campos de texto dentro del módulo "Trabaja en Xisti".
// Permite mantener un estilo uniforme en todos los formularios del registro de conductor.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class WorkInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  const WorkInputField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Etiqueta del campo
        Text(
          label,
          style: TextStyle(
            color: AppTheme.whiteContainer.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        // Campo de texto
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: TextStyle(color: AppTheme.whiteContainer),
          decoration: InputDecoration(
            // Comentario: mantener el mismo borde y radio en todos los estados para evitar cambio de forma al enfocar.
            filled: true,
            fillColor: AppTheme.darkGreyContainer,
            hintText: '',
            hintStyle: TextStyle(color: AppTheme.greyTextColor),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
