import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool locationEnabled = true;
  bool darkModeEnabled = true;
  bool soundEnabled = true;
  String selectedLanguage = 'Español';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          width: size.width,
          decoration: BoxDecoration(
            color: AppTheme.inputBackgroundDark,
            borderRadius: AppTheme.border,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración General',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppTheme.largeSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Sección de Cuenta
              _buildSectionTitle('Cuenta'),
              _buildSettingOption(
                Icons.person,
                'Perfil de Usuario',
                'Edita tu información personal',
                () => _showProfileDialog(),
              ),
              _buildSettingOption(
                Icons.email,
                'Cambiar Email',
                'Actualiza tu dirección de correo',
                () => _showEmailDialog(),
              ),

              const SizedBox(height: 20),

              // Sección de Notificaciones
              _buildSectionTitle('Notificaciones'),
              _buildSwitchOption(
                Icons.notifications,
                'Notificaciones Push',
                'Recibe alertas de nuevos servicios',
                notificationsEnabled,
                (value) => setState(() => notificationsEnabled = value),
              ),
              _buildSwitchOption(
                Icons.vibration,
                'Sonidos',
                'Habilita sonidos de notificación',
                soundEnabled,
                (value) => setState(() => soundEnabled = value),
              ),

              const SizedBox(height: 20),

              // Sección de Privacidad
              _buildSectionTitle('Privacidad y Ubicación'),
              _buildSwitchOption(
                Icons.location_on,
                'Ubicación',
                'Permite compartir tu ubicación',
                locationEnabled,
                (value) => setState(() => locationEnabled = value),
              ),

              const SizedBox(height: 20),

              // Sección de Apariencia
              _buildSectionTitle('Apariencia'),
              _buildSwitchOption(
                Icons.dark_mode,
                'Modo Oscuro',
                'Activa el tema oscuro',
                darkModeEnabled,
                (value) => setState(() => darkModeEnabled = value),
              ),
              _buildLanguageOption(),

              const SizedBox(height: 20),

              // Sección de App
              _buildSectionTitle('Aplicación'),
              _buildSettingOption(
                Icons.info,
                'Acerca de',
                'Versión 1.0.0',
                () => _showAboutDialog(),
              ),
              _buildSettingOption(
                Icons.help,
                'Términos y Condiciones',
                'Lee nuestros términos de uso',
                () => _showTermsDialog(),
              ),
              _buildSettingOption(
                Icons.logout,
                'Cerrar Sesión',
                'Salir de tu cuenta',
                () => _showLogoutDialog(),
                isDestructive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: AppTheme.mediumSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingOption(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTheme.border,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: AppTheme.border,
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? Colors.red.withValues(alpha: 0.2)
                      : AppTheme.primaryColor.withValues(alpha: 0.2),
                  borderRadius: AppTheme.border,
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? Colors.red : AppTheme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isDestructive ? Colors.red : Colors.white,
                        fontSize: AppTheme.mediumSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: AppTheme.smallSize,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchOption(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: AppTheme.border,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              borderRadius: AppTheme.border,
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppTheme.mediumSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: AppTheme.mediumSize,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return AppTheme.primaryColor;
              }
              return null;
            }),
            trackColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return AppTheme.primaryColor.withValues(alpha: 0.5);
              }
              return null;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: AppTheme.border,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              borderRadius: AppTheme.border,
            ),
            child: Icon(Icons.language, color: AppTheme.primaryColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Idioma',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTheme.mediumSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Selecciona tu idioma preferido',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: AppTheme.mediumSize,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showLanguageDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.2),
                borderRadius: AppTheme.border,
              ),
              child: Text(
                selectedLanguage,
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Perfil de Usuario',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Función en desarrollo. Pronto podrás editar tu perfil desde aquí.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Cambiar Email',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Función en desarrollo. Pronto podrás cambiar tu email desde aquí.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Seleccionar Idioma',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'Español',
                style: TextStyle(color: Colors.white),
              ),
              trailing: selectedLanguage == 'Español'
                  ? Icon(Icons.check, color: AppTheme.primaryColor)
                  : null,
              onTap: () {
                setState(() => selectedLanguage = 'Español');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'English',
                style: TextStyle(color: Colors.white),
              ),
              trailing: selectedLanguage == 'English'
                  ? Icon(Icons.check, color: AppTheme.primaryColor)
                  : null,
              onTap: () {
                setState(() => selectedLanguage = 'English');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Acerca de XISTI',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'XISTI App v1.0.0\n\nTu aplicación de transporte confiable.\n\n© 2024 XISTI. Todos los derechos reservados.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Términos y Condiciones',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Al usar esta aplicación, aceptas nuestros términos de servicio y política de privacidad.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Cerrar Sesión',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Estás seguro que quieres cerrar sesión?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función en desarrollo')),
              );
            },
            child: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
