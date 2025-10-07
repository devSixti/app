// este archivo define un widget CustomDrawer que representa un menú lateral personalizado con perfil de usuario, opciones de menú, botón de modo conductor y enlaces a redes sociales.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'widgets/user_profile.dart';
import 'widgets/driver_mode_button.dart';
import 'widgets/social_media_links.dart';
import 'widgets/menu_option.dart';
import '../form_trips/form_trips.dart';
import '../pages_drawer/help_page.dart';
import '../pages_drawer/security_page.dart';
import '../pages_drawer/settings_page.dart';
import '../pages_drawer/support_page.dart';
import '../pages_drawer/driver_wallet_page.dart';
import '../pages_drawer/travels_history_page.dart';
import '../login/login_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, this.isLogedIn = false});
  
  final bool isLogedIn;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.darkDrawerBackground,
      child: SafeArea(
        child: Column(
          children: [
            if (widget.isLogedIn) ...[
              const UserProfile(),
              const SizedBox(height: 20),
            ] else ...[
              // boton de iniciar sesión
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text("Iniciar sesión"),
              ),
            ],
            // Perfil de usuario
            
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FormTrips()),
                      );
                    },
                  ),
                  MenuOption(
                    icon: Icons.history,
                    title: 'Historial de solicitudes',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TravelsHistoryPage()),
                      );
                    },
                  ),
                  MenuOption(
                    icon: Icons.security,
                    title: 'Seguridad',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SecurityPage()),
                      );
                    },
                  ),
                  MenuOption(
                    icon: Icons.settings,
                    title: 'Configuración',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsPage()),
                      );
                    },
                  ),
                  MenuOption(
                    icon: Icons.help_outline,
                    title: 'Ayuda',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HelpPage()),
                      );
                    },
                  ),
                  MenuOption(
                    icon: Icons.support_agent,
                    title: 'Soporte',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SupportPage()),
                      );
                    },
                  ),
                  MenuOption(
                    icon: Icons.account_balance_wallet,
                    title: 'Billetera',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DriverWallet()),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Botón Modo Conductor
            DriverModeButton(),
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