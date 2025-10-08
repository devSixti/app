// este archivo define un widget CustomDrawer que representa un menú lateral personalizado con perfil de usuario, opciones de menú, botón de modo conductor y enlaces a redes sociales.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'widgets/user_profile.dart';
import 'widgets/driver_mode_button.dart';
import 'widgets/social_media_links.dart';
import 'widgets/menu_option.dart';
import '../form_trips/form_trips.dart';
import '../pages_drawer/security/security_page.dart';
import '../pages_drawer/settings/settings_page.dart';
import '../pages_drawer/support/support_page.dart';
import '../pages_drawer/wallet/driver_wallet_page.dart';
import '../pages_drawer/travels_history/travels_history_page.dart';
import '../login/login_page.dart';
import '../pages_drawer/help/help_page_final.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:  Color.fromRGBO(185, 150, 255, 1), // Borde morado
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: const Center(
                          child: Text(
                            "Inicio sesión",
                            style: TextStyle(
                              color: Color.fromRGBO(185, 150, 255, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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