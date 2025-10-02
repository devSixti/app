import 'package:flutter/material.dart';
import 'edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: const Color(0xFF181818),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Editar perfil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(
        child: EditProfileForm(),
      ),
    );
  }
}
