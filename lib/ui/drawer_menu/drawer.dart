// este archivo define un widget CustomDrawer que representa un menú lateral personalizado con perfil de usuario, opciones de menú, botón de modo conductor y enlaces a redes sociales.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'widgets/user_profile.dart';
import 'widgets/menu_option.dart';
import 'widgets/driver_mode_button.dart';
import 'widgets/social_media_links.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.darkDrawerBackground,
      child: SafeArea(
        child: Column(
          children: [
            // Perfil de usuario
            const UserProfile(),
            const SizedBox(height: 20),
            // Opciones del menú
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  MenuOption(
                    icon: Icons.directions_car,
                    title: 'Pedir servicio',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  MenuOption(
                    icon: Icons.history,
                    title: 'Historial de solicitudes',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  MenuOption(
                    icon: Icons.security,
                    title: 'Seguridad',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  MenuOption(
                    icon: Icons.settings,
                    title: 'Configuración',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  MenuOption(
                    icon: Icons.help_outline,
                    title: 'Ayuda',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  MenuOption(
                    icon: Icons.support_agent,
                    title: 'Soporte',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // Botón Modo Conductor
            const DriverModeButton(),
            // Redes sociales
            const SocialMediaLinks(),
            // Espacio inferior
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}