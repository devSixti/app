// Este es el archivo que contiene el widget InputsLocation (El input de la ubicación)

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class InputsLocation extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  final dynamic onChanged;

  final dynamic readOnly;

  const InputsLocation({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly =
        true, // Esto permite que no se pueda escribir dentro del campo
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ), // Espaciado interno del contenedor
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: AppTheme.border,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 28,
          ), // Icono del input (Ej: icono de ubicación)
          const SizedBox(
            width: 12,
          ), // Espacio entre el icono y el TextField (Osea el input)
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: AppTheme.mediumSize,
              ), // Estilo del texto ingresado en el input
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize:
                      18, // Tamaño del texto del placeholder (Ej: "Ubicación de inicio")
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                ), // Ajusta el padding vertical del TextField (ej: para centrar el texto)
              ),
            ),
          ),
        ],
      ),
    );
  }
}