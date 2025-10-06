// este archivo define un widget UserProfile que muestra el perfil del usuario en un drawer.

import 'package:app/ui/perfil_usuario_xisti/screens/perfil_usuario_xisti_screen.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

// Este widget muestra el perfil del usuario con su avatar, nombre y puntuación.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProfileScreen(context),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
        children: [
          // Avatar del usuario
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[700],
            ),
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(width: 15),
          
          // Información del usuario
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del usuario
                const Text(
                  'David',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Estrellas y puntuación
                Row(
                  children: [
                    // 5 estrellas
                    ...List.generate(5, (index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    )),
                    
                    const SizedBox(width: 6),
                    
                    // Puntuación
                    const Text(
                      '5.066',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  void _navigateToProfileScreen(BuildContext context) {
    // Cerrar el drawer primero
    Navigator.pop(context);
    
    // Navegar a la pantalla de perfil
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PerfilUsuarioXistiScreen(),
      ),
    );
  }
}