// Archivo para cambiar la pestaña completa de "Editar"

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkDrawerBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(255, 255, 255, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Editar perfil', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
        centerTitle: true,
      ),
      body: const Center(
        child: EditProfileForm(),
      ),
    );
  }
}
