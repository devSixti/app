// Archivo que define la pantalla principal del perfil de usuario Xisti, que incluye un 
//encabezado, una tarjeta de perfil, una sección de calificaciones de conductores y una sección de trabajo en Xisti. 
//También maneja la navegación a la pantalla de edición de perfil.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

// Importa tus modelos
import '../models/user_profile.dart';
import '../models/driver_rating.dart';
import '../models/work_option.dart';

// Importa tus componentes
import '../components/profile_header.dart';
import '../components/user_profile_card.dart';
import '../components/driver_ratings_section.dart';
import '../components/work_in_xisti_section.dart';

// Importa la pantalla de edición real
import 'profile_edit_screen.dart';

/// Pantalla principal del perfil de usuario Xisti
class PerfilUsuarioXistiScreen extends StatefulWidget {
  const PerfilUsuarioXistiScreen({super.key});

  @override
  State<PerfilUsuarioXistiScreen> createState() =>
      _PerfilUsuarioXistiScreenState();
}

class _PerfilUsuarioXistiScreenState extends State<PerfilUsuarioXistiScreen> {
  // Datos de ejemplo del usuario
  final UserProfile _userProfile = const UserProfile(
    fullName: 'David Chacón',
    phoneNumber: '+57 1234567890',
    location: 'Bogotá, CO',
    avatarUrl: null,
  );

  // Datos de ejemplo para calificaciones de conductores
  final List<DriverRating> _driverRatings = [
    const DriverRating(driverName: 'Conductor 1', rating: 4.8, avatarUrl: null),
    const DriverRating(driverName: 'Conductor 2', rating: 4.9, avatarUrl: null),
    const DriverRating(driverName: 'Conductor 3', rating: 4.7, avatarUrl: null),
    const DriverRating(driverName: 'Conductor 4', rating: 4.6, avatarUrl: null),
    const DriverRating(driverName: 'Conductor 5', rating: 4.8, avatarUrl: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(), // El header personalizado lo ponemos abajo
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con botón Editar
            ProfileHeader(
              onEditTap: _onEditProfile,
            ),

            // Tarjeta del perfil del usuario
            UserProfileCard(
              userProfile: _userProfile,
            ),

            const SizedBox(height: 20),

            // Sección de calificaciones de conductores
            DriverRatingsSection(
              driverRatings: _driverRatings,
            ),

            const SizedBox(height: 20),

            // Sección de trabajo en Xisti
            WorkInXistiSection(
              workOptions: WorkOption.defaultOptions,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileEditScreen(),
      ),
    );
  }
}

