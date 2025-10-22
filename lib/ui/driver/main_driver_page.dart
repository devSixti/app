// Este archivo contiene la pantalla principal MainDriverPage.
// Ahora guarda las direcciones al cerrar el LocationPanel con "Volver".
// Además, muestra las direcciones guardadas en los cuadros principales usando controller.

import 'package:app/ui/form_trips/widgets/search_driver_button.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:app/core/theme/app_theme.dart';
// Importamos los widgets personalizados
import 'package:app/ui/form_trips/widgets/drag_handle.dart';
import "package:app/ui/drawer_menu/drawer.dart";

// Importacion del mapa
import 'package:app/ui/map/map_widget.dart';

class MainDriverPage extends StatefulWidget {
  const MainDriverPage({super.key});

  @override
  State<MainDriverPage> createState() => _MainDriverPageState();
}

class _MainDriverPageState extends State<MainDriverPage> {
  String selectedVehicle = "Moto";
  double? offeredFare;

  // Guardamos las direcciones en el estado principal
  String? startLocation;
  String? endLocation;

  // Controladores para mostrar texto fijo en InputsLocation
  late TextEditingController _startController;
  late TextEditingController _endController;

  final DraggableScrollableController _draggableController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController();
    _endController = TextEditingController();
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppTheme.whiteContainer // Solo el ícono visible
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      drawer: const CustomDrawer(),

      body: Stack(
        children: [
          // Antes teniamos el Container(color: AppTheme.darkGreyContainer)
          // Ahora ponemos el mapa en toda la parte inferior del Stack
          const Positioned.fill(
            child: MapScreen(), // Mapa gratuito con OpenStreetMap
          ),

          // Mantenemos el panel deslizable encima del mapa
          DraggableScrollableSheet(
            controller: _draggableController,
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkDrawerBackground,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(1),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const DragHandle(),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Flexible(
                              flex: 0,
                              child: SearchDriverButton(
                                onPressed: () {
                                  if (offeredFare == null) {
                                    debugPrint(
                                      "Debes ingresar una tarifa antes de buscar.",
                                    );
                                  } else {
                                    debugPrint(
                                      "Buscando conductor para $selectedVehicle con tarifa: $offeredFare",
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
