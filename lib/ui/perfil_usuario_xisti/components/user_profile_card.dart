import 'package:flutter/material.dart';
import '../models/user_profile.dart';

/// Componente que muestra el avatar, nombre y información del usuario
class UserProfileCard extends StatelessWidget {
  final UserProfile userProfile;

  const UserProfileCard({
    super.key,
    required this.userProfile,
  });

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
            color: const Color(0xFF232323),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.18),
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
                  color: Colors.grey.shade300,
                  border: Border.all(
                    color: Colors.grey.shade400,
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
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Información de contacto y ubicación
              Text(
                '${userProfile.phoneNumber} | ${userProfile.location}',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
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
      color: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        size: 50,
        color: Colors.grey.shade600,
      ),
    );
  }
}