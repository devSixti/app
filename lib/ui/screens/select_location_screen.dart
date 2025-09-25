import 'package:app/ui/handles/drag_handle.dart';
import 'package:app/ui/widgets/cards/location_card.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/widgets/buttons/back_button_custom.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
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
                        LocationCard(
                          icon: Icons.location_on,
                          iconColor: AppTheme.primaryColor,
                          text: "Ubicación inicial",
                        ),
                        const SizedBox(height: 20),
                        LocationCard(
                          icon: Icons.location_on,
                          iconColor: AppTheme.purpleColor,
                          text: "Ubicación final",
                        ),
                        const SizedBox(height: 500),
                        // Botón volver
                        BackButtonCustom(
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
