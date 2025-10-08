import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: AppBar(
        title: const Text('Seguridad', style: TextStyle(color: Colors.white)),
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
                'Configuración de Seguridad',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppTheme.largeSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildSecurityOption(
                context,
                Icons.lock,
                'Cambiar Contraseña',
                'Actualiza tu contraseña para mayor seguridad',
                () => _showPasswordDialog(context),
              ),

              _buildSecurityOption(
                context,
                Icons.security,
                'Verificación en Dos Pasos',
                'Protege tu cuenta con autenticación adicional',
                () => _showTwoFactorDialog(context),
              ),

              _buildSecurityOption(
                context,
                Icons.privacy_tip,
                'Privacidad de Datos',
                'Controla cómo usamos tu información',
                () => _showPrivacyDialog(context),
              ),

              _buildSecurityOption(
                context,
                Icons.report,
                'Reportar Problema',
                'Reporta actividades sospechosas o problemas',
                () => _showReportDialog(context),
              ),

              _buildSecurityOption(
                context,
                Icons.block,
                'Usuarios Bloqueados',
                'Gestiona tu lista de usuarios bloqueados',
                () => _showBlockedUsersDialog(context),
              ),

              _buildSecurityOption(
                context,
                Icons.history,
                'Historial de Sesiones',
                'Revisa el historial de acceso a tu cuenta',
                () => _showSessionHistoryDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.2),
                  borderRadius: AppTheme.border,
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: 24),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
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

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Cambiar Contraseña',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Función en desarrollo. Pronto podrás cambiar tu contraseña desde aquí.',
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

  void _showTwoFactorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Verificación en Dos Pasos',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Función en desarrollo. La autenticación de dos factores estará disponible próximamente.',
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

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Privacidad de Datos',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Tu privacidad es importante para nosotros. Revisa nuestra política de privacidad para más información.',
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

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Reportar Problema',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Si has experimentado algún problema de seguridad, contáctanos a través del soporte.',
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

  void _showBlockedUsersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Usuarios Bloqueados',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'No tienes usuarios bloqueados actualmente.',
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

  void _showSessionHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.inputBackgroundDark,
        title: const Text(
          'Historial de Sesiones',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Última sesión: Hoy a las 14:30\nDispositivo: Android\nUbicación: Medellín, Colombia',
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
}
