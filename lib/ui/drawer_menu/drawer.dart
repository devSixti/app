// este archivo define un widget CustomDrawer que representa un menú lateral personalizado con perfil de usuario, opciones de menú, botón de modo conductor y enlaces a redes sociales.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'widgets/user_profile.dart';
import 'widgets/driver_mode_button.dart';
import 'widgets/menu_option.dart';
import '../form_trips/form_trips.dart';
import '../pages_drawer/security/security_page.dart';
import '../pages_drawer/settings/settings_page.dart';
import '../pages_drawer/support/support_page.dart';
import '../pages_drawer/wallet/driver_wallet_page.dart';
import '../pages_drawer/travels_history/travels_history_page.dart';
import '../login/login_page.dart';
import '../pages_drawer/help/help_page.dart';
import 'social_panel/xisti_panel_trigger.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    this.isLogedIn = true,
    this.isDriver = true,
  }); // true = logueado, false = no logueado

  final bool isLogedIn;
  final bool isDriver;

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
              UserProfile(isDriver: widget.isDriver),
            ] else ...[
              // boton de iniciar sesión
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(185, 150, 255, 1), // Borde morado
                      width: 2.0,
                    ),
                    borderRadius: AppTheme.border,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      borderRadius: AppTheme.border,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
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
            // Opciones del menú
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  MenuOption(
                    icon: Icons.directions_car,
                    title: 'Pedir servicio',
                    onTap: () {
                      if (widget.isLogedIn) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormTrips(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                  MenuOption(
                    icon: Icons.security,
                    title: 'Seguridad',
                    onTap: () {
                      if (widget.isLogedIn) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecurityPage(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                  MenuOption(
                    icon: Icons.settings,
                    title: 'Configuración',
                    onTap: () {
                      if (widget.isLogedIn) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                  MenuOption(
                    icon: Icons.help_outline,
                    title: 'Ayuda',
                    onTap: () {
                      if (widget.isLogedIn) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpPage(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                  MenuOption(
                    icon: Icons.support_agent,
                    title: 'Soporte',
                    onTap: () {
                      if (widget.isLogedIn) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SupportPage(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                  if (widget.isDriver)
                    MenuOption(
                      icon: Icons.account_balance_wallet,
                      title: 'Billetera',
                      onTap: () {
                        if (widget.isLogedIn) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DriverWalletPage(),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      },
                    ),
                  
                  if (!widget.isDriver)
                    MenuOption(
                      icon: Icons.history,
                      title: 'Historial de solicitudes',
                      onTap: () {
                        if (widget.isLogedIn) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TravelsHistoryPage(),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
            // Botón Modo Conductor
            DriverModeButton(isDriver: widget.isDriver),
            // Xisti panel trigger (reemplaza la sección de redes sociales anterior)
            const XistiPanelTrigger(),
            // Espacio inferior
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
