// Este archivo es para organizar todo el campo completo de la opción "Cambiar contraseña"

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controladores para los campos de texto
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkDrawerBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.whiteContainer),
          onPressed: () => Navigator.pop(context), // Regresa a la pantalla anterior
        ),
        title: const Text(
          'Cambiar Contraseña',
          style: TextStyle(
            color: AppTheme.whiteContainer,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Contenido principal
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Por tu seguridad, usa una contraseña que combine letras, números y símbolos. El máximo permitido es de 20 caracteres.',
              style: TextStyle(
                color: AppTheme.lightGreyContainer,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Campo: Contraseña actual
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              maxLength: 20, // Máximo 20 caracteres
              decoration: InputDecoration(
                hintText: 'Contraseña actual', // Texto fijo (no se mueve)
                hintStyle: const TextStyle(color: AppTheme.lightGreyContainer),
                filled: true,
                fillColor: AppTheme.inputBackgroundDark,
                counterText: '', // Oculta el contador "0/20"

                // Se define el mismo borde para todos los estados
                border: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Campo: Nueva contraseña
            TextField(
              controller: newPasswordController,
              obscureText: true,
              maxLength: 20, // Máximo 20 caracteres
              decoration: InputDecoration(
                hintText: 'Nueva contraseña', // Texto fijo (no se mueve)
                hintStyle: const TextStyle(color: AppTheme.lightGreyContainer),
                filled: true,
                fillColor: AppTheme.inputBackgroundDark,
                counterText: '', // Oculta el contador "0/20"

                // Se mantiene el mismo estilo sin cambios al escribir
                border: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Campo: Confirmar nueva contraseña
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              maxLength: 20, // Máximo 20 caracteres
              decoration: InputDecoration(
                hintText: 'Confirmar nueva contraseña', // Texto fijo (no se mueve)
                hintStyle: const TextStyle(color: AppTheme.lightGreyContainer),
                filled: true,
                fillColor: AppTheme.inputBackgroundDark,
                counterText: '', // Oculta el contador "0/20"

                // Sin bordes visibles al escribir o enfocar
                border: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppTheme.border,
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Botón de guardar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Aquí luego se implementará la lógica para actualizar la contraseña
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidad de cambio de contraseña pendiente.'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: AppTheme.blackContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.border,
                  ),
                ),
                child: const Text(
                  'Guardar nueva contraseña',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
