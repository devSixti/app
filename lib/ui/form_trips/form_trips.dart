import 'package:flutter/material.dart' hide BackButton;
import 'package:app/core/theme/app_theme.dart';

import 'package:app/ui/form_trips/widgets/drag_handle.dart';
import 'package:app/ui/form_trips/widgets/input_location_start.dart';
import 'package:app/ui/form_trips/widgets/back_button.dart';

class FormTrips extends StatefulWidget {
  const FormTrips({super.key});

  @override
  State<FormTrips> createState() => _FormTripsState();
}

class _FormTripsState extends State<FormTrips> {
  @override
  Widget build(BuildContext context) { // Pantalla de selección de ubicación con DraggableScrollableSheet
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color.fromARGB(255, 179, 177, 177),
          ),
          onPressed: () {},
        ),
      ),
      body: Stack(
        children: [
          Container(color: AppTheme.darkGreyContainer),
          DraggableScrollableSheet(
            initialChildSize: 0.3, // Tamaño inicial del sheet
            minChildSize: 0.2, // Tamaño mínimo al que se puede contraer
            maxChildSize: 1.0, // Tamaño máximo al que se puede expandir
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkScaffold,
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
                        // Tarjetas de ubicación
                        InputsLocation(
                          icon: Icons.location_on,
                          iconColor: AppTheme.primaryColor,
                          hintText: "Ubicación inicial",
                        ),
                        const SizedBox(height: 20),
                        InputsLocation(
                          icon: Icons.location_on,
                          iconColor: AppTheme.purpleColor,
                          hintText: "Ubicación final",
                        ),
                        const SizedBox(height: 500),
                        // Botón volver
                        BackButton(
                          onPressed: () => Navigator.pop(context),
                          text: "Volver",
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
