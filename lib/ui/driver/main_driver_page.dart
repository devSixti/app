// Este archivo contiene la pantalla principal MainDriverPage.
// Ahora guarda las direcciones al cerrar el LocationPanel con "Volver".
// Además, muestra las direcciones guardadas en los cuadros principales usando controller.
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart' hide BackButton;
import 'package:app/core/theme/app_theme.dart';
// Panel and buttons moved to separate widgets
import 'package:app/ui/driver/models/incoming_service.dart';
import 'package:app/ui/driver/widgets/simulation_button.dart';
import 'package:app/ui/driver/widgets/driver_panel.dart';
import 'package:app/ui/driver/widgets/waiting_sheet.dart';
import 'package:app/ui/driver/widgets/incoming_services_overlay.dart';
import 'package:app/ui/driver/data/simulation_data.dart';
import "package:app/ui/drawer_menu/drawer.dart";

// Importacion del mapa
import 'package:app/ui/map/map_widget.dart';

class MainDriverPage extends StatefulWidget {
  const MainDriverPage({super.key});

  @override
  State<MainDriverPage> createState() => _MainDriverPageState();
}

class _MainDriverPageState extends State<MainDriverPage> with SingleTickerProviderStateMixin {
  String selectedVehicle = "Moto";
  double? offeredFare;

  // Control flag para mostrar/ocultar el panel deslizable
  bool _panelVisible = true;

  // Guardamos las direcciones en el estado principal
  String? startLocation;
  String? endLocation;

  // Controladores para mostrar texto fijo en InputsLocation
  late TextEditingController _startController;
  late TextEditingController _endController;

  final DraggableScrollableController _draggableController =
      DraggableScrollableController();

  // Controller para el sheet de 'Esperando' (tiene su propio controller para poder escuchar tamaño)
  final DraggableScrollableController _waitingDraggableController = DraggableScrollableController();

  // Track whether the sheet is currently expanded above a small threshold
  bool _sheetExpanded = false;
  // Umbral para considerar el sheet "expandido". Aumentado para que pequeñas arrastres
  // no oculten el drawer inmediatamente; el drawer se ocultará cuando el sheet
  // haya subido lo suficiente (p. ej. hasta donde están los botones).
  final double _sheetExpandThreshold = 0.5;
  // Track waiting sheet expansion
  bool _waitingSheetExpanded = false;
  // Umbral similar para el sheet de 'Esperando'
  final double _waitingSheetExpandThreshold = 0.5;

  // Servicios entrantes simulados (lista)
  final List<IncomingService> _incomingServices = [];
  final Duration _incomingAnimDuration = const Duration(milliseconds: 350);
  final Random _rand = Random();
  // Mostrar texto 'ando...' cuando el conductor pulse Comenzar y no haya peticiones
  bool _showWaitingText = false;
  Timer? _waitingTimer;
  int _waitingDots = 0;

  void _startWaitingDots() {
    _waitingTimer?.cancel();
    _waitingDots = 0;
    _waitingTimer = Timer.periodic(const Duration(milliseconds: 600), (t) {
      setState(() {
        _waitingDots = (_waitingDots + 1) % 4; // 0..3 dots
      });
    });
  }

  void _stopWaitingDots() {
    _waitingTimer?.cancel();
    _waitingTimer = null;
    setState(() {
      _waitingDots = 0;
    });
  }

  // Datos de ejemplo para simulaciones (extraídos a un archivo para mantener este archivo pequeño)
  // Vienen de: ui/driver/data/simulation_data.dart

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController();
    _endController = TextEditingController();
    // Escuchar cambios en el tamaño del sheet para mostrar/ocultar elementos dependientes
    _draggableController.addListener(_handleSheetSizeChange);
  // Escuchar también el sheet de 'Esperando'
  _waitingDraggableController.addListener(_handleWaitingSheetSizeChange);
    // nothing for waiting dots here; timer will be started on demand
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    _draggableController.removeListener(_handleSheetSizeChange);
    _waitingDraggableController.removeListener(_handleWaitingSheetSizeChange);
    _waitingTimer?.cancel();
    super.dispose();
  }

  void _handleSheetSizeChange() {
    double s;
    try {
      s = _draggableController.size;
    } catch (e) {
      // Controller not attached yet
      return;
    }
    if (s > _sheetExpandThreshold && !_sheetExpanded) {
      setState(() {
        _sheetExpanded = true;
      });
    } else if (s <= _sheetExpandThreshold && _sheetExpanded) {
      setState(() {
        _sheetExpanded = false;
      });
    }
  }

  void _handleWaitingSheetSizeChange() {
    double s;
    try {
      s = _waitingDraggableController.size;
    } catch (e) {
      return;
    }
    if (s > _waitingSheetExpandThreshold && !_waitingSheetExpanded) {
      setState(() {
        _waitingSheetExpanded = true;
      });
    } else if (s <= _waitingSheetExpandThreshold && _waitingSheetExpanded) {
      setState(() {
        _waitingSheetExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nota: el botón 'Desconectar' ahora está incrustado dentro de cada sheet para que viaje con él.
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // Ocultar el drawer si cualquiera de los sheets está expandido o si hay peticiones entrantes
        leading: (!_sheetExpanded && !_waitingSheetExpanded && _incomingServices.isEmpty)
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: AppTheme.whiteContainer, // Solo el ícono visible
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        actions: [
          // Mostrar la campanita de simulación sólo después de comenzar (cuando el panel está oculto)
          // Mostrar la campanita mientras no estemos en espera/hoja expandida. Se mantiene visible
          // aunque existan peticiones entrantes (no desaparece al añadir una simulación).
          if (!_panelVisible && !_sheetExpanded && !_waitingSheetExpanded)
            SimulationButton(
              onSimulate: () {
                setState(() {
                  final name = sampleNames[_rand.nextInt(sampleNames.length)];
                  final from = sampleFrom[_rand.nextInt(sampleFrom.length)];
                  final to = sampleTo[_rand.nextInt(sampleTo.length)];
                  final fare = (5000 + _rand.nextInt(25001)).toDouble();
                  final rating = double.parse((3.5 + _rand.nextDouble() * 1.5).toStringAsFixed(1));
                  final payment = paymentMethods[_rand.nextInt(paymentMethods.length)];

                  _incomingServices.insert(
                    0,
                    IncomingService(
                      passengerName: name,
                      from: from,
                      to: to,
                      fare: fare,
                      rating: rating,
                      paymentMethod: payment,
                      createdAt: DateTime.now(),
                    ),
                  );
                  _showWaitingText = false;
                  _stopWaitingDots();
                });
              },
            ),
        ],
      ),

  // No mostrar drawer cuando hay sheets expandidos o cuando hay peticiones entrantes
  drawer: (!_sheetExpanded && !_waitingSheetExpanded && _incomingServices.isEmpty) ? const CustomDrawer() : null,

      body: Stack(
        children: [
          // Mapa en toda la parte inferior del Stack
          const Positioned.fill(
            child: MapScreen(),
          ),

          // Panel deslizable encima del mapa (ocultable)
          if (_panelVisible)
            DriverPanel(
              controller: _draggableController,
              onBegin: () {
                setState(() {
                  _panelVisible = false;
                  _showWaitingText = true;
                });
                _startWaitingDots();
              },
            ),

          // Mostrar lista de tarjetas de servicio entrante en la pantalla (más abajo)
          if (_incomingServices.isNotEmpty && !_sheetExpanded && !_waitingSheetExpanded)
            IncomingServicesOverlay(
              services: _incomingServices,
              animDuration: _incomingAnimDuration,
              onAccept: (svc) async {
                setState(() {
                  offeredFare = svc.fare;
                  _incomingServices.clear();
                  if (_incomingServices.isEmpty) {
                    _showWaitingText = true;
                    _startWaitingDots();
                  } else {
                    _stopWaitingDots();
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Servicio aceptado — Tarifa: \$${offeredFare?.toStringAsFixed(2)}')));
              },
              onDecline: (svc) {
                setState(() {
                  _incomingServices.removeWhere((s) => s.id == svc.id);
                  if (_incomingServices.isEmpty) {
                    _showWaitingText = true;
                    _startWaitingDots();
                  }
                });
              },
            ),
            // Mostrar el sheet colapsado (idéntico al Comenzar) en la zona inferior cuando estamos en estado 'Esperando...'
            if (!_panelVisible && _incomingServices.isEmpty && _showWaitingText)
              WaitingSheet(
                controller: _waitingDraggableController,
                waitingDots: _waitingDots,
                onDisconnect: () {
                  _stopWaitingDots();
                  setState(() {
                    _showWaitingText = false;
                    _panelVisible = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Desconectado')));
                },
              ),
              // Eliminado: ahora el botón 'Desconectar' está dentro de los sheets para que viaje con ellos
        ],
      ),
    );
  }
}

// IncomingService and animated card moved to separate components in ui/driver/widgets
