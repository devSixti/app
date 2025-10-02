import 'package:flutter/material.dart' hide BackButton;
import 'package:app/core/theme/app_theme.dart';


import 'package:app/ui/drawer_menu/drawer.dart';
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
    return Container(
      color: Colors.black, // Fondo negro puro para toda la pantalla
      child: Scaffold(
        backgroundColor: Colors.black, // Fondo negro puro para el Scaffold
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.black, // Fondo negro puro para el AppBar
          elevation: 1,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color.fromARGB(255, 179, 177, 177),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(color: Colors.black),
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.2,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF201F1F), // darkScaffold
                    borderRadius: BorderRadius.vertical(
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
      ),
    );
  }
}
