import 'package:flutter/material.dart';
import '../models/driver_rating.dart';

/// Componente de la sección de calificaciones de conductores  
class DriverRatingsSection extends StatelessWidget {
  final List<DriverRating> driverRatings;

  const DriverRatingsSection({
    super.key,
    required this.driverRatings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título con estrella y "null"
          Row(
            children: [
              const Text(
                'Calificaciones de conductores',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'null',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Avatares superpuestos con contador
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 40,
                child: Stack(
                  children: _buildOverlappingAvatars(),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+${driverRatings.length > 3 ? driverRatings.length - 3 + 12 : 12}', // +15 como en la imagen
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOverlappingAvatars() {
    List<Widget> avatars = [];
    
    // Mostrar máximo 3 avatares superpuestos
    for (int i = 0; i < (driverRatings.length > 3 ? 3 : driverRatings.length); i++) {
      avatars.add(
        Positioned(
          left: i * 20.0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: (driverRatings[i].avatarUrl?.isNotEmpty ?? false)
                  ? Image.network(
                      driverRatings[i].avatarUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => 
                          _buildDefaultDriverAvatar(),
                    )
                  : _buildDefaultDriverAvatar(),
            ),
          ),
        ),
      );
    }
    
    return avatars;
  }

  Widget _buildDefaultDriverAvatar() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade600,
      child: Icon(
        Icons.person,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}