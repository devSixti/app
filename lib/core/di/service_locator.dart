import 'package:get_it/get_it.dart';
import '../network/health_check_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Register services as singletons
  
  // Register health check service
  getIt.registerLazySingleton<HealthCheckService>(
    () => const HealthCheckService(),
  );
  
  // You can add more services here as your app grows
}
