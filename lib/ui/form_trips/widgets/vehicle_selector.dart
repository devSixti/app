// Este archivo contiene el widget VehicleSelector (selector de vehículo)

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

// Definición de la clase para cada opción de vehículo
class VehicleOption {
  final String name;
  final IconData iconData;
  final String category;
  final Color? iconColor;
  final String? assetPath;

  const VehicleOption({
    required this.name,
    required this.iconData,
    required this.category,
    this.iconColor,
    this.assetPath,
  });
}

// Estructura de datos completa para todas las opciones
const Map<String, List<VehicleOption>> vehicleOptionsMap = {
  "Carros": [
    VehicleOption(
      name: "Economico",
      iconData: Icons.directions_car,
      category: "Carros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "Confort ",
      iconData: Icons.local_taxi,
      category: "Carros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "VIP",
      iconData: Icons.sports_bar,
      category: "Carros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "Eléctrico",
      iconData: Icons.electric_car,
      category: "Carros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
  ],
  "Motos": [
    VehicleOption(
      name: "Economica",
      iconData: Icons.motorcycle,
      category: "Motos",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "Confort",
      iconData: Icons.two_wheeler,
      category: "Motos",
      iconColor: AppTheme.inputBackgroundLight,
    ),
  ],
  "Taxi": [
    VehicleOption(
      name: "Normal",
      iconData: Icons.local_taxi_sharp,
      category: "Taxi",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "Eléctrico ",
      iconData: Icons.electric_rickshaw,
      category: "Taxi",
      iconColor: AppTheme.inputBackgroundLight,
    ),
  ],
  "Otros": [
    VehicleOption(
      name: "Envio Moto",
      iconData: Icons.delivery_dining,
      category: "Otros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "Envio Carro",
      iconData: Icons.airport_shuttle,
      category: "Otros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "Envio Cicla",
      iconData: Icons.pedal_bike,
      category: "Otros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
    VehicleOption(
      name: "Mascotas",
      iconData: Icons.pets,
      category: "Otros",
      iconColor: AppTheme.inputBackgroundLight,
    ),
  ],
};

class VehicleSelector extends StatefulWidget {
  final ValueChanged<String> onVehicleSelected;
  final VoidCallback? onTap;
  const VehicleSelector({
    super.key,
    required this.onVehicleSelected,
    this.onTap,
  });

  @override
  State<VehicleSelector> createState() => _VehicleSelectorState();
}

class _VehicleSelectorState extends State<VehicleSelector> {
  String _selectedVehicle = "Economico";

  VehicleOption? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          widget.onTap ??
          () {
            _showVehicleOptions(context);
          },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.border,
          color: AppTheme.inputBackgroundDark,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(_selectedOption?.iconData ?? Icons.directions_car, size: 38),

            SizedBox(width: 12),

            Text(
              _selectedVehicle,
              style: const TextStyle(
                color: AppTheme.inputBackgroundLight,
                fontSize: AppTheme.mediumSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Este es el Widget para renderizar un ítem de opción (el icono y el texto)
  Widget _buildVehicleItem(
    BuildContext context,
    VehicleOption option,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () => Navigator.pop(context, option.name),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppTheme.purpleColor : AppTheme.transparent,
            ),
            child: Icon(option.iconData, size: 40),
          ),
          SizedBox(height: 4),
          Text(
            option.name,
            style: TextStyle(
              color: AppTheme.inputBackgroundLight,
              fontSize: AppTheme.smallSize,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String categoryName,
    List<VehicleOption> options,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "$categoryName:",
            style: const TextStyle(
              color: AppTheme.inputBackgroundLight,
              fontSize: AppTheme.mediumSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Wrap(
            spacing: 16,
            children: options.map((option) {
              final String optionKey = option.name;
              final bool isSelected = _selectedVehicle == optionKey;
              return _buildVehicleItem(context, option, isSelected);
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showVehicleOptions(BuildContext context) async {
    bool showAllCategories = false;

    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Theme(
              data: ThemeData.dark().copyWith(
                canvasColor: AppTheme.darkDrawerBackground,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Show only Carros and Motos by default
                      ...vehicleOptionsMap.entries
                          .where(
                            (entry) =>
                                entry.key == 'Carros' || entry.key == 'Motos',
                          )
                          .map((entry) {
                            return _buildCategorySection(
                              context,
                              entry.key,
                              entry.value,
                            );
                          }),

                      // Show other categories if showAllCategories is true
                      if (showAllCategories)
                        ...vehicleOptionsMap.entries
                            .where(
                              (entry) =>
                                  entry.key != 'Carros' && entry.key != 'Motos',
                            )
                            .map((entry) {
                              return _buildCategorySection(
                                context,
                                entry.key,
                                entry.value,
                              );
                            }),

                      // Show Ver más button if not showing all categories
                      if (!showAllCategories && vehicleOptionsMap.length > 2)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showAllCategories = true;
                            });
                          },
                          child: const Text(
                            'Ver más servicios',
                            style: TextStyle(
                              color: AppTheme.purpleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedVehicle = selected;

        // Aqui podemos buscar la opción seleccionada en el mapa y guardarla
        for (final entry in vehicleOptionsMap.entries) {
          for (final option in entry.value) {
            final optionKey = option.name; // Solo comparando por nombre
            if (optionKey == selected) {
              _selectedOption = option;
              break;
            }
          }
        }
      });
      widget.onVehicleSelected(selected);
    }
  }
}
