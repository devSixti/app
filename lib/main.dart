import 'package:flutter/widgets.dart';
import '/core/initialize/app_initializer.dart';
import '/ui/xisti_app.dart';

Future<void> main() async {
  await appInitializer(
    envFile: '.env',
    appWidget: const NewXistiApp(),
  );
}
