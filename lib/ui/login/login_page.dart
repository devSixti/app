import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'components/login_components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingresa tu número de celular';
    }
    // Remover espacios y caracteres especiales
    String phone = value.replaceAll(RegExp(r'[^\d]'), '');

    if (phone.length < 10) {
      return 'El número debe tener al menos 10 dígitos';
    }
    if (phone.length > 10) {
      return 'El número no puede tener más de 10 dígitos';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular autenticación simple
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        // Navegar directamente a la pantalla principal
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al iniciar sesión. Intenta nuevamente'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Logo o icono
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.inputBackgroundDark,
                      borderRadius: AppTheme.border,
                    ),
                    child: const Icon(
                      Icons.car_rental,
                      size: 60,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Título
                const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: AppTheme.largeSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtítulo
                Text(
                  'Ingresa tu número de celular',
                  style: TextStyle(
                    fontSize: AppTheme.mediumSize,
                    color: Colors.grey.shade400,
                  ),
                ),

                const SizedBox(height: 40),

                // Campo Número de celular
                CustomTextField(
                  hintText: 'Número de celular',
                  prefixIcon: Icons.phone_outlined,
                  controller: _phoneController,
                  validator: _validatePhone,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 32),

                // Botón Iniciar sesión
                PrimaryButton(
                  text: 'Iniciar sesión',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 24),

                // Separador
                const DividerWithText(text: 'o'),

                const SizedBox(height: 24),

                // Botón Continuar con Google
                const SizedBox(height: 60),

                // Texto adicional
                Center(
                  child: Text(
                    'Al iniciar sesión aceptas nuestros\ntérminos y condiciones',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppTheme.smallSize,
                      color: Colors.grey.shade500,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
