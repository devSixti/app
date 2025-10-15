import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'widget/security_header_widget.dart';
import 'widget/security_settings_widget.dart';
import 'widget/privacy_data_widget.dart';
import 'widget/security_tips_widget.dart';
import 'widget/security_contact_widget.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SecurityHeaderWidget(),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SecuritySettingsWidget(
                    onOptionTap: (opt) => _onOptionTap(context, opt),
                    biometricEnabled: false,
                    onBiometricChanged: (_) {},
                  ),

                  const SizedBox(height: 24),

                  PrivacyDataWidget(
                    onOptionTap: (opt) => _onOptionTap(context, opt),
                  ),
                  
                  const SizedBox(height: 24),

                  const SecurityTipsWidget(),
                  
                  const SizedBox(height: 24),

                  SecurityContactWidget(
                    onContactSecurity: () => _showSecurityContactDialog(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Handle option taps from the widgets
  void _onOptionTap(BuildContext context, String option) {
    switch (option) {
      case 'password':
        _showComingSoonDialog(context, 'Cambiar Contraseña');
        break;
      case 'twoFactor':
        _showComingSoonDialog(context, 'Verificación en Dos Pasos');
        break;
      case 'biometric':
        _showComingSoonDialog(context, 'Autenticación Biométrica');
        break;
      case 'devices':
        _showComingSoonDialog(context, 'Dispositivos Conectados');
        break;
      case 'downloadData':
        _showComingSoonDialog(context, 'Descargar Datos');
        break;
      case 'deleteAccount':
        _showDeleteAccountDialog(context);
        break;
      case 'privacyPolicy':
        _showComingSoonDialog(context, 'Política de Privacidad');
        break;
      default:
        _showComingSoonDialog(context, 'Función');
    }
  }

  // Métodos de diálogos

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: const BorderSide(color: Colors.red),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.red, size: 24),
              SizedBox(width: 12),
              Text(
                'Eliminar Cuenta',
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            '⚠️ ADVERTENCIA: Esta acción es irreversible.\n\n¿Estás seguro de que quieres eliminar permanentemente tu cuenta?\n\nTodos tus datos, historial de viajes e información personal serán eliminados para siempre.',
            style: TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: AppTheme.lightGreyContainer)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: AppTheme.whiteContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Eliminar Cuenta'),
            ),
          ],
        );
      },
    );
  }

  void _showSecurityContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: BorderSide(color: Colors.orange.withOpacity(0.3)),
          ),
          title: const Row(
            children: [
              Icon(Icons.security_rounded, color: Colors.orange, size: 24),
              SizedBox(width: 12),
              Text(
                'Contacto de Seguridad',
                style: TextStyle(color: AppTheme.whiteContainer, fontSize: 18),
              ),
            ],
          ),
          content: const Text(
            'Si has detectado algún problema de seguridad o actividad sospechosa en tu cuenta, contáctanos inmediatamente:\n\n📧 security@xisti.com\n📞 +57 (1) 234-5678\n\nNuestro equipo de seguridad te ayudará las 24 horas.',
            style: TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: AppTheme.whiteContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.border,
            side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.3)),
          ),
          title: Text(
            feature,
            style: const TextStyle(color: AppTheme.whiteContainer, fontSize: 18),
          ),
          content: Text(
            'Esta función de seguridad estará disponible próximamente para brindarte mayor protección.',
            style: const TextStyle(color: AppTheme.lightGreyContainer, fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.blackContainer,
                shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
              ),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}