// Archivo que muestra el avatar, nombre y información del usuario

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/perfil_usuario_xisti/models/user_profile.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfile userProfile;

  const UserProfileCard({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
            minWidth: 340,
            minHeight: 220,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFF232323,
            ), // Color del contenedor de la parte de arrriba.
            borderRadius: AppTheme.border,
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Color.fromRGBO(0, 0, 0, 1).withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar circular grande
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    width: 2.5,
                  ),
                ),
                child: ClipOval(
          child: userProfile.avatarUrl != null
                      ? Image.network(
                          userProfile.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(),
                        )
                      : _buildDefaultAvatar(),
                ),
              ),
              const SizedBox(height: 22),
              // Nombre del usuario
              Text(
                userProfile.fullName,
                style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: AppTheme.largeSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Información de contacto y ubicación
              Text(
                '${userProfile.phoneNumber} | ${userProfile.location}',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: AppTheme.mediumSize,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(255, 255, 255, 1),
      child: Icon(Icons.person, size: 50, color: Colors.grey.shade600),
    );
  }
}
