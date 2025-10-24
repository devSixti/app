// Archivo completo en el que se implementa la vista del mapa

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController; // Controlador del mapa
  LatLng _currentPosition = const LatLng(6.18331, -75.59957); // Ubicación

  @override
  void initState() {
    super.initState();
    _mapController = MapController(); // Inicializa el mapa
    _getUserLocation(); // Obtiene la ubicación
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled(); // Verifica GPS
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission(); // Verifica permisos
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission(); // Solicita permisos
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
// Permiso denegado permanentemente
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude); // Asigna ubicación real
        _mapController.move(_currentPosition, 15); // Centra el mapa
      });
    // ignore: empty_catches
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController, // Controlador del mapa
        options: MapOptions(
          initialCenter: _currentPosition, // Centro inicial
          initialZoom: 13, // Zoom inicial
          minZoom: 3, // Zoom mínimo
          maxZoom: 22, // Zoom máximo
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/dark_all/{z}/{x}/{y}.png', // Fuente del mapa
            userAgentPackageName: 'com.example.app', // Nombre del paquete
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80, // Ancho del marcador
                height: 80, // Alto del marcador
                point: _currentPosition, // Punto del marcador
                child: const Icon(
                  Icons.location_pin,
                  color: AppTheme.purpleColor,
                  size: 40, // Tamaño del ícono
                ),
              ),
            ],
          ),
        ],
  
      ),
    );
  }
}