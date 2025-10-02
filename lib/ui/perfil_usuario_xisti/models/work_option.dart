/// Tipos de opciones de trabajo en Xisti
enum WorkOptionType {
  cityDriver,
  taxiDriver,
  delivery,
}

/// Modelo que representa una opción de trabajo
class WorkOption {
  final WorkOptionType type;
  final String title;
  final String subtitle;
  final String iconAsset;

  const WorkOption({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
  });

  /// Datos de ejemplo para las opciones de trabajo
  static const List<WorkOption> defaultOptions = [
    WorkOption(
      type: WorkOptionType.cityDriver,
      title: 'Conductor de ciudad',
      subtitle: 'Negocea tarifas',
      iconAsset: 'XI', // Logo XI
    ),
    WorkOption(
      type: WorkOptionType.taxiDriver,
      title: 'Conductor de Taxi',
      subtitle: 'Aumenta tus viajes',
      iconAsset: 'XI', // Logo XI
    ),
    WorkOption(
      type: WorkOptionType.delivery,
      title: 'Repartidor',
      subtitle: 'Entrega encomiendas',
      iconAsset: 'XI', // Logo XI
    ),
  ];
}