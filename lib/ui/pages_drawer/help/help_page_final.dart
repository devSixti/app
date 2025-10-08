import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: AppTheme.whiteContainer,
      fontSize: AppTheme.mediumSize,
    );

    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar moderno con efecto glassmorphism
          SliverAppBar(
            expandedHeight: 280.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: AppTheme.darkScaffold,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.blackContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.whiteContainer),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.15),
                      AppTheme.purpleColor.withOpacity(0.15),
                      AppTheme.inputBackgroundDark,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    // Icono central con múltiples capas
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryColor.withOpacity(0.1),
                                AppTheme.purpleColor.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: AppTheme.primaryColor.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.purpleColor.withOpacity(0.2),
                                AppTheme.primaryColor.withOpacity(0.2),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                          child: const Icon(
                            Icons.help_center_rounded,
                            color: AppTheme.whiteContainer,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Centro de Ayuda',
                      style: TextStyle(
                        color: AppTheme.whiteContainer,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.blackContainer.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.purpleColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Tu guía completa de soporte',
                        style: TextStyle(
                          color: AppTheme.lightGreyContainer,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Grid de secciones principales
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _buildCategoryCard(
                        'Cuenta',
                        Icons.person_outline_rounded,
                        AppTheme.primaryColor,
                        [
                          {'icon': Icons.person_add_rounded, 'title': '¿Cómo registrarme?', 'content': 'Descarga la app, selecciona "Registrarse" y completa tu información personal. Verifica tu correo para activar tu cuenta.'},
                          {'icon': Icons.lock_reset_rounded, 'title': '¿Olvidé mi contraseña?', 'content': 'Selecciona "Olvidé mi contraseña" en la pantalla de login y sigue las instrucciones para restablecerla.'},
                        ],
                      ),
                      _buildCategoryCard(
                        'Seguridad',
                        Icons.security_rounded,
                        AppTheme.purpleColor,
                        [
                          {'icon': Icons.shield_rounded, 'title': '¿Cómo protejo mi información?', 'content': 'Tu información está protegida con medidas avanzadas. No compartas tus datos de acceso y cierra sesión en dispositivos compartidos.'},
                          {'icon': Icons.warning_amber_rounded, 'title': '¿Cuenta comprometida?', 'content': 'Comunícate inmediatamente con soporte para tomar las medidas necesarias y proteger tu cuenta.'},
                        ],
                      ),
                      _buildCategoryCard(
                        'Pagos',
                        Icons.payment_rounded,
                        AppTheme.primaryColor,
                        [
                          {'icon': Icons.credit_card, 'title': '¿Métodos de pago?', 'content': 'Aceptamos Nequi, Bancolombia, Daviplata y efectivo. Debes comunicar previamente tu método de pago preferido.'},
                          {'icon': Icons.calculate_outlined, 'title': '¿Cómo se calculan las tarifas?', 'content': 'Las tarifas se basan en distancia, tiempo del viaje y demanda en la zona. Ve el estimado antes de confirmar.'},
                        ],
                      ),
                      _buildCategoryCard(
                        'Viajes',
                        Icons.car_rental_rounded,
                        AppTheme.purpleColor,
                        [
                          {'icon': Icons.location_on_outlined, 'title': '¿Cambiar ubicación?', 'content': 'Puedes cambiar tu ubicación de recogida antes de que llegue el conductor desde los detalles del viaje.'},
                          {'icon': Icons.report_problem_outlined, 'title': '¿Problemas en el viaje?', 'content': 'Usa la función de ayuda en la app o contacta soporte. Tu seguridad es nuestra prioridad.'},
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Sección de búsqueda rápida
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.inputBackgroundDark,
                          AppTheme.darkGreyContainer,
                          AppTheme.inputBackgroundDark,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.blackContainer.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.primaryColor.withOpacity(0.2),
                                    AppTheme.purpleColor.withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.search_rounded,
                                color: AppTheme.whiteContainer,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                'Búsqueda Rápida',
                                style: TextStyle(
                                  color: AppTheme.whiteContainer,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildQuickTag('Registro', AppTheme.primaryColor),
                            _buildQuickTag('Pagos', AppTheme.purpleColor),
                            _buildQuickTag('Seguridad', AppTheme.primaryColor),
                            _buildQuickTag('Conductores', AppTheme.purpleColor),
                            _buildQuickTag('Ubicación', AppTheme.primaryColor),
                            _buildQuickTag('Tarifas', AppTheme.purpleColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Sección de contacto premium
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.purpleColor.withOpacity(0.15),
                          AppTheme.primaryColor.withOpacity(0.15),
                          AppTheme.blackContainer.withOpacity(0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 0.3, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: AppTheme.purpleColor.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.purpleColor.withOpacity(0.1),
                          blurRadius: 25,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: AppTheme.blackContainer.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.purpleColor.withOpacity(0.3),
                                    AppTheme.primaryColor.withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: AppTheme.blackContainer.withOpacity(0.3),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.whiteContainer.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.headset_mic_rounded,
                                color: AppTheme.whiteContainer,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          '¿Necesitas ayuda personalizada?',
                          style: TextStyle(
                            color: AppTheme.whiteContainer,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Nuestro equipo está aquí para ayudarte',
                          style: TextStyle(
                            color: AppTheme.lightGreyContainer,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.primaryColor.withOpacity(0.2),
                                      AppTheme.primaryColor.withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppTheme.primaryColor.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.email_rounded,
                                      color: AppTheme.primaryColor,
                                      size: 28,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        color: AppTheme.whiteContainer,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'soporte@xisti.com',
                                      style: TextStyle(
                                        color: AppTheme.lightGreyContainer,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.purpleColor.withOpacity(0.2),
                                      AppTheme.purpleColor.withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppTheme.purpleColor.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.phone_rounded,
                                      color: AppTheme.purpleColor,
                                      size: 28,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Teléfono',
                                      style: TextStyle(
                                        color: AppTheme.whiteContainer,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '+57 123 456 7890',
                                      style: TextStyle(
                                        color: AppTheme.lightGreyContainer,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color accentColor, List<Map<String, dynamic>> faqs) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.inputBackgroundDark,
            AppTheme.darkGreyContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accentColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.blackContainer.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _showFAQBottomSheet(title, faqs, accentColor),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withOpacity(0.2),
                        accentColor.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accentColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.whiteContainer,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  width: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withOpacity(0.8),
                        accentColor.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showFAQBottomSheet(String category, List<Map<String, dynamic>> faqs, Color accentColor) {
    // Esta función abriría un bottom sheet con las preguntas específicas
    // Por ahora solo es un placeholder para el diseño
  }
}