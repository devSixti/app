import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Inicializador de la aplicación.
Future<void> appInitializer({
  required String envFile,
  required Widget appWidget,
}) async {
  // Asegura que el binding esté inicializado para operaciones async antes de runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Limpia cualquier dato persistido de Información Básica al iniciar la app
  // El formulario usa claves que inician con 'basic_info_'
  final prefs = await SharedPreferences.getInstance();
  final keysToRemove = prefs.getKeys().where((k) => k.startsWith('basic_info_')).toList();
  for (final k in keysToRemove) {
    await prefs.remove(k);
  }

  runApp(appWidget);
}
