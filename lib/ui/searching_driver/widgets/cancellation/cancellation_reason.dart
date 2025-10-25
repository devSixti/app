// Modelo de datos para las razones de cancelación
import 'package:flutter/material.dart';

// Exportaciones de los widgets de cancelación
export 'cancellation_reason.dart';
export 'cancellation_reason_option.dart';
export 'cancellation_reason_dialog.dart';

class CancellationReason {
  final String title;
  final String description;
  final IconData icon;
  final String id;

  const CancellationReason({
    required this.title,
    required this.description,
    required this.icon,
    required this.id,
  });

  // Lista de razones de cancelación predefinidas
  static List<CancellationReason> get reasons => [
        const CancellationReason(
          id: 'excessive_wait',
          title: 'Tiempo de espera excesivo',
          description:
              'El conductor tarda demasiado en llegar al punto de recogida.',
          icon: Icons.access_time,
        ),
        const CancellationReason(
          id: 'unknown_driver',
          title: 'Conductor desconocido',
          description:
              'El conductor que llego no coincide con la información mostrada en la app.',
          icon: Icons.person_outline,
        ),
        const CancellationReason(
          id: 'unknown_vehicle',
          title: 'Automovil desconocido',
          description:
              'Las placas del automovil o la descripción del vehículo no coinciden con la información mostrada en la app.',
          icon: Icons.directions_car_outlined,
        ),
        const CancellationReason(
          id: 'inadequate_vehicle',
          title: 'Vehículo inadecuado',
          description: 'El vehículo se encuentra en mal estado.',
          icon: Icons.car_crash_outlined,
        ),
        const CancellationReason(
          id: 'change_plans',
          title: 'Cambio de planes',
          description: 'Ya no necesito el viaje.',
          icon: Icons.change_circle_outlined,
        ),
        const CancellationReason(
          id: 'security_issues',
          title: 'Problemas de seguridad',
          description: 'Me siento inseguro o incómodo el conductor.',
          icon: Icons.shield_outlined,
        ),
      ];
}
