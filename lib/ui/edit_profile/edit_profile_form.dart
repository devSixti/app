// Archivo sobre la parte para "Editar"

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'profile_avatar.dart';
import 'profile_text_field.dart';
import 'save_button.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.darkDrawerBackground,
            borderRadius: BorderRadius.circular(15), // Border del menu de editar
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProfileAvatar(),
              const SizedBox(height: 24),
              const ProfileTextField(label: 'Nombre', initialValue: 'David'),
              const SizedBox(height: 12),
              const ProfileTextField(label: 'Apellidos', initialValue: 'Chacón'),
              const SizedBox(height: 12),
              const ProfileTextField(label: 'Email', initialValue: 'Registrado con otro proveedor', enabled: false),
              const SizedBox(height: 12),
              const ProfileTextField(label: '+57', initialValue: '1234567890', icon: Icons.edit),
              const SizedBox(height: 12),
              const ProfileTextField(label: '+57', initialValue: '', hintText: 'Contacto de emergencia', maxLength: 10),
              const SizedBox(height: 24),
              const SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
