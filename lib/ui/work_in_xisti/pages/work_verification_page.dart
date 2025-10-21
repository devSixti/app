// Pantalla de verificación en proceso, posterior al registro completado.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/pages_drawer/main_driver_page.dart';
import 'package:flutter/material.dart';

class WorkVerificationPage extends StatelessWidget {
  const WorkVerificationPage({super.key});

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
                    Icon(Icons.verified_user_rounded, size: 96, color: AppTheme.primaryColor),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'Verificación en '),
                          TextSpan(text: 'proceso', style: TextStyle(color: AppTheme.primaryColor)),
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
                    const SizedBox(height: 12),
                    Text(
                      'Tus documentos y datos están siendo revisados por nuestro equipo de validación.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.whiteContainer.withOpacity(0.85),
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
                      MaterialPageRoute(builder: (_) => const MainDriverPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Listo',
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
