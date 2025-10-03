// Este es el archivo que contiene la entrada principal de la aplicación.
// Inicializa la app cargando variables de entorno desde ".env"
// y ejecuta el widget raíz (NewXistiApp).

import '/core/initialize/app_initializer.dart';
import '/ui/xisti_app.dart';

Future<void> main() async {
  await appInitializer(
    envFile: '.env',
    appWidget: const NewXistiApp(),
  );
}
