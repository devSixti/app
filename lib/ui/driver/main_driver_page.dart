import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/driver_toggle.dart';
import 'widgets/services_manager.dart';
import '../drawer_menu/drawer.dart';
import '../map/map_widget.dart';

class MainDriverPage extends StatefulWidget {
  const MainDriverPage({super.key, this.testMode = false});

  // When true, the widget avoids heavy/complex children (MapScreen)
  // and some layout choices to make widget tests more stable.
  final bool testMode;

  @override
  State<MainDriverPage> createState() => _MainDriverPageState();
}

class _MainDriverPageState extends State<MainDriverPage>
    with TickerProviderStateMixin {
  bool isDriverActive = false;
  bool isGpsEnabled = true;
  final GlobalKey<ServicesManagerState> _servicesManagerKey = GlobalKey<ServicesManagerState>();

  static const _prefKeyIsDriverActive = 'isDriverActive';

  @override
  void initState() {
    super.initState();
    _loadDriverState();
  }

  Future<void> _loadDriverState() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getBool(_prefKeyIsDriverActive);
    if (val != null) {
      setState(() {
        isDriverActive = val;
      });
    } else {
      // Default to true (Libre) to preserve previous behavior
      setState(() {
        isDriverActive = true;
      });
      await prefs.setBool(_prefKeyIsDriverActive, isDriverActive);
    }
  }

  Future<void> _saveDriverState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeyIsDriverActive, value);
  }

  // Services management moved to widgets/services_manager.dart

  @override
  void dispose() {
    // No timers stored in parent; child widgets manage their own controllers.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Column(
          children: [
            DriverToggleButton(
              isDriverActive: isDriverActive,
              onChanged: (val) async {
                setState(() {
                  isDriverActive = val;
                });
                await _saveDriverState(isDriverActive);
              },
            ),
            if (!isGpsEnabled) const SizedBox(height: 3),
            if (!isGpsEnabled)
              Text(
                'Activa tu ubicación',
                style: TextStyle(
                  fontSize: AppTheme.smallSize,
                  color: AppTheme.purpleColor,
                  height: 0,
                ),
              ),
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
        actions: [
          IconButton(
            tooltip: 'Simular servicio',
            // Deshabilitar el botón si el conductor está ocupado
            onPressed: isDriverActive ? () => _servicesManagerKey.currentState?.addSimulatedService(context) : null,
            icon: Icon(
              Icons.notifications,
              color: isDriverActive ? Colors.white : Colors.white54,
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(isDriver: true),

      // 🟣 Overlay vertical (desde arriba hacia abajo)
      body: Stack(
        children: [
          if (widget.testMode)
            const Positioned.fill(child: SizedBox.shrink())
          else
            const Positioned.fill(child: MapScreen()),

          ServicesManager(
            key: _servicesManagerKey,
            isDriverActive: isDriverActive,
            onAccepted: () async {
              setState(() {
                isDriverActive = false;
              });
              await _saveDriverState(isDriverActive);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Servicio aceptado')));
            },
          ),
        ],
      ),
    );
  }

  
}

// ServiceNotification moved to its own file: widgets/service_notification.dart
