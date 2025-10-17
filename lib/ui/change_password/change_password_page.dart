
import 'package:app/ui/change_password/widgets/password_input_field.dart.dart';
import 'package:app/ui/change_password/widgets/save_button.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => Navigator.pop(context),
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

            PasswordInputField(
              controller: currentPasswordController,
              hintText: 'Contraseña actual',
            ),
            const SizedBox(height: 20),

            PasswordInputField(
              controller: newPasswordController,
              hintText: 'Nueva contraseña',
            ),
            const SizedBox(height: 20),

            PasswordInputField(
              controller: confirmPasswordController,
              hintText: 'Confirmar nueva contraseña',
            ),
            const SizedBox(height: 30),

            SaveButton(
              text: 'Guardar nueva contraseña',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidad de cambio de contraseña pendiente.'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
