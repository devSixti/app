import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/service_locator.dart';

/// Inicializador de la aplicación.
Future<void> appInitializer({
  required String envFile,
  required Widget appWidget,
}) async {
  // Asegura que el binding esté inicializado para operaciones async antes de runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependency injection
  await setupLocator();

  // Limpia cualquier dato persistido de Información Básica al iniciar la app
  // El formulario usa claves que inician con 'basic_info_'
  final prefs = await SharedPreferences.getInstance();
  final keysToRemove = prefs.getKeys().where((k) => k.startsWith('basic_info_')).toList();
  for (final k in keysToRemove) {
    await prefs.remove(k);
  }

  // Limpia cualquier dato persistido de Documento de Identidad al iniciar la app
  // El formulario usa claves que inician con 'identity_'
  final identityKeys = prefs.getKeys().where((k) => k.startsWith('identity_')).toList();
  for (final k in identityKeys) {
    await prefs.remove(k);
  }

  // Limpia cualquier dato persistido de Licencia al iniciar la app
  // El formulario usa claves que inician con 'license_'
  final licenseKeys = prefs.getKeys().where((k) => k.startsWith('license_')).toList();
  for (final k in licenseKeys) {
    await prefs.remove(k);
  }

  // Limpia cualquier dato persistido de Certificado de antecedentes al iniciar la app
  // El formulario usa claves que inician con 'background_'
  final backgroundKeys = prefs.getKeys().where((k) => k.startsWith('background_')).toList();
  for (final k in backgroundKeys) {
    await prefs.remove(k);
  }

  // Limpia cualquier dato persistido de SOAT al iniciar la app
  // El formulario usa claves que inician con 'soat_'
  final soatKeys = prefs.getKeys().where((k) => k.startsWith('soat_')).toList();
  for (final k in soatKeys) {
    await prefs.remove(k);
  }

  // Limpia cualquier dato persistido de Información de vehículo al iniciar la app
  // El formulario usa claves que inician con 'vehicle_'
  final vehicleKeys = prefs.getKeys().where((k) => k.startsWith('vehicle_')).toList();
  for (final k in vehicleKeys) {
    await prefs.remove(k);
  }

  // Limpia cualquier dato persistido de Selfie de verificación al iniciar la app
  // Las claves inician con 'selfie_'
  final selfieKeys = prefs.getKeys().where((k) => k.startsWith('selfie_')).toList();
  for (final k in selfieKeys) {
    await prefs.remove(k);
  }

  // Limpia cualquier dato persistido de Información de bicicleta al iniciar la app
  // Las claves inician con 'bicycle_'
  final bicycleKeys = prefs.getKeys().where((k) => k.startsWith('bicycle_')).toList();
  for (final k in bicycleKeys) {
    await prefs.remove(k);
  }

  runApp(appWidget);
}
