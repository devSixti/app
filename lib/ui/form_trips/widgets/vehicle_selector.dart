// Este archivo contiene el widget VehicleSelector (selector de vehículo)

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

// Definición de la clase para cada opción de vehículo
class VehicleOption {
  final String name;
  final IconData
  iconData; // Usamos IconData para iconos de Flutter por simplicidad
  final String category; // Para saber a qué categoría pertenece
  final Color? iconColor; // Color opcional para el icono
  final String? assetPath; // Opcional si usas imágenes o assets

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
  "Autos": [
    VehicleOption(
      name: "Economy",
      iconData: Icons.directions_car,
      category: "Autos",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "Confort ",
      iconData: Icons.local_taxi,
      category: "Autos",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "VIP",
      iconData: Icons.sports_bar,
      category: "Autos",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "Eléctrico",
      iconData: Icons.electric_car,
      category: "Autos",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
  ],
  "Motos": [
    VehicleOption(
      name: "Economy ",
      iconData: Icons.motorcycle,
      category: "Motos",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "Confort",
      iconData: Icons.two_wheeler,
      category: "Motos",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
  ],
  "Taxi": [
    VehicleOption(
      name: "Normal",
      iconData: Icons.local_taxi_sharp,
      category: "Taxi",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "Eléctrico ",
      iconData: Icons.electric_rickshaw,
      category: "Taxi",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
  ],
  "Otros": [
    VehicleOption(
      name: "Envio Moto",
      iconData: Icons.delivery_dining,
      category: "Otros",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "Envio Carro",
      iconData: Icons.airport_shuttle,
      category: "Otros",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "Envio Cicla",
      iconData: Icons.pedal_bike,
      category: "Otros",
      iconColor: Color.fromARGB(255, 255, 255, 255),
    ),
    VehicleOption(
      name: "Mascotas",
      iconData: Icons.pets,
      category: "Otros",
      iconColor: Color.fromARGB(255, 255, 255, 255),
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
  String _selectedVehicle = "Economy";

  // Aqui guardamos la opción seleccionada completa para mostrar también el ícono
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
          borderRadius: AppTheme.border, // Bordes redondeados
          color: const Color.fromRGBO(66, 66, 66, 1),
        ),
        padding: const EdgeInsets.all(13), // Espaciado interno
        child: Row(
          children: [
            // Aqui podemos mostrar el ícono de la opción seleccionada en lugar de fijo
            Icon(
              _selectedOption?.iconData ?? Icons.directions_car,
              color: _selectedOption?.iconColor ?? AppTheme.lightPrimaryContainer,
                size: 38, // Tamaño del icono principal
            ),
            const SizedBox(width: 11), // Espacio entre el icono y el texto
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedVehicle, // Esto hace que muestre los textos.
                  style: const TextStyle(
                    color: AppTheme.lightPrimaryContainer,
                    fontSize: AppTheme.mediumSize, // Aqui se puede editar el tamaño de las letras principales.
                  ), // Estilo del texto
                ),
                const Text(
                  "Cambiar >",
                  style: TextStyle(
                    color: AppTheme.lightPrimaryContainer,
                    fontSize: AppTheme.smallSize,
                  ), // Estilo del texto secundario
                ),
              ],
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
      onTap: () => Navigator.pop(
        context,
        option.name, // Cambiado para que solo devuelva el nombre
      ), // Devuelve solo el nombre
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Colors.blue.shade700
                  : const Color.fromARGB(0, 255, 255, 255),
            ),
            child: Icon(
              option.iconData,
              size: 40, // Con esto podemos ajustar el tamaño de los iconos.
              color: option.iconColor ?? Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            option.name,
            style: TextStyle(
              color: isSelected
                  ? Colors.blue
                  : AppTheme.inputBackgroundLight,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            "$categoryName:",
            style: const TextStyle(
              color: AppTheme.lightPrimaryContainer,
              fontSize: AppTheme.mediumSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 20.0,
            runSpacing: 10.0,
            children: options.map((option) {
              final String optionKey = option.name; // Comparación solo por nombre
              final bool isSelected = _selectedVehicle == optionKey;
              return _buildVehicleItem(context, option, isSelected);
            }).toList(),
          ),
        ),
        const Divider(color: Colors.white10, height: 30, thickness: 1),
      ],
    );
  }

  void _showVehicleOptions(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(255, 33, 33, 33),
      builder: (context) {
        return Theme(
          data: ThemeData.dark().copyWith(
            canvasColor: const Color.fromARGB(255, 255, 0, 0),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: vehicleOptionsMap.entries.map((entry) {
                  return _buildCategorySection(context, entry.key, entry.value);
                }).toList(),
              ),
            ),
          ),
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
