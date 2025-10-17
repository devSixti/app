// Este widget define el botón reutilizable utilizado para mostrar opciones
// como “Conductor”, “Repartidor”, “Carro”, “Moto”, etc.
// Acepta un widget personalizado como ícono (Icon, Image o SvgPicture).

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

/// Botón reutilizable que representa cada opción (Conductor, Repartidor, etc).
/// El parámetro [leading] acepta cualquier widget (Icon, Image, SvgPicture) para facilitar el cambio futuro.
class WorkOptionButton extends StatelessWidget {
  final Widget leading;
  final String label;
  final void Function()? onTap;

  const WorkOptionButton({
    super.key,
    required this.leading,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.darkGreyContainer,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              // Icono / imagen proporcionada por el caller
              leading,

              const SizedBox(width: 12),

              // Texto
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Flecha derecha
              Icon(Icons.arrow_forward_ios, size: 18, color: AppTheme.purpleColor),
            ],
          ),
        ),
      ),
    );
  }
}
