// Pantalla de bienvenida cuando el registro está completado.

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/work_in_xisti/pages/work_verification_page.dart';

class WorkReadyPage extends StatelessWidget {
  const WorkReadyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Imagen ilustrativa
                    SizedBox(
                      height: 240,
                      child: Image.asset(
                        'assets/images/Journey-amico.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: '¡Bienvenido al equipo de\nconductores de '),
                          TextSpan(
                            text: 'XISTI!',
                            style: TextStyle(color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.whiteContainer,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Agradecemos tu confianza y estamos aquí para asegurarnos de que tengas una experiencia excepcional. '
                      '¡Todo está en su lugar! Inicia esta nueva aventura y ayudemos juntos a nuestros pasajeros a llegar a su destino de manera segura y eficiente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.whiteContainer.withOpacity(0.8),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const WorkVerificationPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Iniciar',
                    style: TextStyle(
                      color: AppTheme.blackContainer,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
