import 'package:flutter/material.dart';

/// Inicializador de la aplicación.
Future<void> appInitializer({
  required String envFile,
  required Widget appWidget,
}) async {
  runApp(appWidget);
}
