// Este archivo contiene la pantalla principal FormTrips.
// Ahora guarda las direcciones al cerrar el LocationPanel con "Volver".
// Además, muestra las direcciones guardadas en los cuadros principales usando controller.

import 'package:app/ui/form_trips/widgets/search_driver_button.dart';
import 'package:app/ui/form_trips/widgets/vehicle_selector.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:app/core/theme/app_theme.dart';
// Importamos los widgets personalizados
import 'package:app/ui/form_trips/widgets/drag_handle.dart';
import 'package:app/ui/form_trips/widgets/input_location_start.dart';
import 'package:app/ui/form_trips/widgets/custom_back_button.dart';
import 'package:app/ui/offer_price_panel/offer_price_field.dart';
import 'package:app/ui/form_trips/widgets/comment_button.dart';
import 'package:app/ui/form_trips/widgets/location_panel.dart'; 
import "package:app/ui/drawer_menu/drawer.dart";

// Importacion del mapa
import 'package:app/ui/map/map_widget.dart';

class FormTrips extends StatefulWidget {
  const FormTrips({super.key});

  @override
  State<FormTrips> createState() => _FormTripsState();
}

class _FormTripsState extends State<FormTrips> {
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

  void _openLocationPanel() async {
    // Esperamos a que el panel devuelva los valores de las direcciones
    final result = await showModalBottomSheet<Map<String, String?>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return LocationPanel(
          initialStart: startLocation,
          initialEnd: endLocation,
          // Cuando se cierra, devolvemos las direcciones
          onClose: (start, end) {
            Navigator.pop(context, {"start": start, "end": end});
          },
        );
      },
    );

    // Guardamos los valores devueltos si no son nulos
    if (result != null) {
      setState(() {
        startLocation = result["start"];
        endLocation = result["end"];
        _startController.text = startLocation ?? "";
        _endController.text = endLocation ?? "";
      });
    }
  }

  void _handleMainBackButton() {
    if (_draggableController.size > 0.5) {
      _draggableController.animateTo(
        0.5,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
            initialChildSize: 0.5,
            minChildSize: 0.5,
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
                        SizedBox(height: screenHeight * 0.01),

                        // Campo Ubicación inicial
                        InputsLocation(
                          icon: 'assets/images/pin_verde.png',
                          iconColor: AppTheme.primaryColor,
                          hintText: "Ubicación inicial",
                          controller: _startController,
                          onTap: _openLocationPanel,
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Campo Ubicación final
                        InputsLocation(
                          icon: 'assets/images/pin_morado.png',
                          iconColor: AppTheme.purpleColor,
                          hintText: "Ubicación final",
                          controller: _endController,
                          onTap: _openLocationPanel,
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Input tarifa + botón de conversación
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: OfferPriceField(
                                onChanged: (value) {
                                  setState(() {
                                    offeredFare = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            SizedBox(
                              width: screenWidth * 0.12,
                              child: CommentButton(
                                onPressed: () {
                                  debugPrint("Abrir conversación...");
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: VehicleSelector(
                                onVehicleSelected: (String value) {
                                  setState(() {
                                    selectedVehicle = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.03),
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

                        SizedBox(height: screenHeight * 0.38),

                        Center(
                          child: CustomBackButton(
                            onPressed: _handleMainBackButton,
                            text: "Volver",
                            width: screenWidth * 0.5,
                            textColor: AppTheme.lightPrimaryContainer,
                          ),
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
