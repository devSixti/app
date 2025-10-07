// Pantalla de carga (Splash) de Xisti
// Muestra únicamente el logo centrado
// Luego entra automáticamente a la pantalla principal (FormTrips)

import 'package:flutter/material.dart';
import 'package:app/ui/form_trips/form_trips.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // El tiempo total de espera es de 3 segundos, incluyendo la duración de la animación de transición.
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          // Utilizamos PageRouteBuilder para crear una transición personalizada con efecto fade (desvanecimiento)
          PageRouteBuilder(
            // La duración de la transición se establece en 500 milisegundos (0.5 segundos)
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const FormTrips(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Animación de desvanecimiento (FadeTransition) para que la pantalla aparezca suavemente
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo oscuro del estilo Xisti
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),

      body: SafeArea(
        child: Center(
          // Solo se muestra el logo centrado
          child: Image.asset(
            'assets/videos/animacion-logo-de-carga-sin-fo-unscreen.gif',
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              // En caso de que falte el asset, muestra un ícono de error
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.image_not_supported,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Logo no encontrado',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}