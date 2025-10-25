import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../drawer_menu/drawer.dart';
import 'widgets/driver_service_card.dart';
import 'widgets/button_group_custom.dart';
import 'widgets/driver_toggle.dart';

class ServicesList extends StatefulWidget {
  const ServicesList({super.key});

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  bool isDriverActive = false;
  bool isGpsEnabled = true;
  List<Map<String, dynamic>> services = [
    {
      'pickUp': 'Centro Comercial Santa Fe',
      'destination': 'Universidad Nacional',
      'price': '15000',
      'distance': '8.5',
      'userName': 'Carlos',
      'userRating': 4.5,
      'ratingCount': 23,
      'payMethod': 'nequi',
      'requestTime': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: Column(
          children: [
            DriverToggleButton(
              isDriverActive: isDriverActive,
              onChanged: (v) {
                setState(() {
                  isDriverActive = v;
                });
              },
            ),
            if (!isGpsEnabled) ...[
              const SizedBox(height: 3),
              Text(
                'Activa tu ubicación',
                style: TextStyle(
                  fontSize: AppTheme.smallSize,
                  color: AppTheme.purpleColor,
                  height: 0,
                ),
              ),
            ],
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
                  leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (BuildContext builderContext) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(builderContext).openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    color: const Color.fromRGBO(21, 21, 21, 0.9),
                    borderRadius: AppTheme.border,
                  ),
                  child: const Icon(Icons.menu_rounded, color: Colors.white),
                ),
              );
            },
          ),
          ),
      ),
  drawer: const CustomDrawer(isDriver: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.02),
          child: Column(
            children: [
              // Barra de botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [ButtonGroupCustom('RECEPCIÓN DE SERVICIOS XISTI')],
              ),
              // Contenedor principal
              Container(
                width: double.infinity,
                height: size.height - size.height * 0.15,
                padding: EdgeInsets.symmetric(
                  vertical: size.width * 0.04,
                  horizontal: size.width * 0.02,
                ),
                  decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, -1),
                    ),
                  ],
                  color: AppTheme.inputBackgroundDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                ),
                child: isDriverActive
                    ? ListView.builder(
                        itemCount: services.length,
                          itemBuilder: (context, index) {
                          final service = services[index];
                          return DriverServiceCard(service: service);
                        },
                      )
                    : const Center(
                        child: Text(
                          'Actívate como conductor para recibir servicios',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppTheme.mediumSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Toggle UI was extracted to widgets/driver_toggle.dart
}

// Service card and button group were moved to widgets:
// - widgets/driver_service_card.dart
// - widgets/button_group_custom.dart
