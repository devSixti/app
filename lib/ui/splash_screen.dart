// Pantalla de carga (Splash) de Xisti
// Muestra el logo centrado y verifica la conexión con el backend
// Luego entra automáticamente a la pantalla principal (FormTrips)

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/form_trips/form_trips.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/network/health_check_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isChecking = true;
  String _statusMessage = 'Verificando conexión...';

  @override
  void initState() {
    super.initState();
    _checkBackendConnection();
  }

  Future<void> _checkBackendConnection() async {
    try {
      final healthCheckService = getIt<HealthCheckService>();
      final isConnected = await healthCheckService.checkBackendConnection();
      
      if (mounted) {
        setState(() {
          _isChecking = false;
          _statusMessage = isConnected 
              ? 'Conexión exitosa' 
              : '';
          _isConnected = isConnected;
        });

        if (isConnected) {
          // Solo navegar si hay conexión
          Future.delayed(const Duration(seconds: 1), _navigateToNextScreen);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isChecking = false;
          _statusMessage = '';
          _isConnected = false;
        });
      }
    }
  }

  // Agregar esta variable de instancia
  bool _isConnected = false;

  void _navigateToNextScreen() {
    if (!mounted || !_isConnected) return;
    
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => const FormTrips(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  // Método para manejar el reintento de conexión
  void _retryConnection() {
    if (_isChecking) return;
    
    setState(() {
      _isChecking = true;
      _statusMessage = 'Reintentando conexión...';
    });
    
    _checkBackendConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo oscuro del estilo Xisti
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo centrado
              Image.asset(
                'assets/videos/animacion-logo-de-carga-sin-fo-unscreen.gif',
                width: 200,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              
              // Estado de la conexión
              if (_isChecking)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              else if (!_isConnected)
                Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppTheme.purpleColor,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _statusMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _retryConnection,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar conexión'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.purple,
                        foregroundColor: AppTheme.purpleColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  _statusMessage,
                  style: const TextStyle(
                    color: AppTheme.purpleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}