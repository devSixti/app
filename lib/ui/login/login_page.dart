import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/login_components.dart';
import 'package:app/core/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su número de celular';
    }
    if (value.length < 10) {
      return 'El número debe tener al menos 10 dígitos';
    }
    return null;
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simular proceso de login
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      // Aquí iría la lógica de autenticación
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Iniciando sesión...')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          
                          // Botón de atrás
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 24,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Logo
                          Center(
                            child: Image.asset(
                              'assets/images/logo_xisti_variacion_verde.png',
                              height: 100, 
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          const SizedBox(height: 25),
                          
                          // Título
                          const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              fontSize: AppTheme.fontSizeLarge,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          
                          // Subtítulo
                          Text(
                            'Ingresa tu número de celular',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          
                          const SizedBox(height: 25),
                          
                          // Campo Número de celular con indicador de país
                          TextFormField(
                            controller: _phoneController,
                            validator: _validatePhone,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.white),
                            maxLength: 10,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (
                              BuildContext context, {
                              required int currentLength,
                              required bool isFocused,
                              required int? maxLength,
                            }) {
                              return Text(
                              '$currentLength/$maxLength',
                              style: TextStyle(
                                color: AppTheme.purpleLigth, // Cambia el color aquí
                                fontSize: 12,
                              ),
                              );
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Número de celular',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              prefixIcon: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade800,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('🇨🇴', style: TextStyle(fontSize: 16)),
                                          SizedBox(width: 4),
                                          Text(
                                            '+57',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      height: 20,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade700),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF6B46C1), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red, width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                          ),
                          
                          const SizedBox(height: 10),
                          
                          // Botón Iniciar sesión
                          PrimaryButton(
                            text: 'Iniciar sesión',
                            onPressed: _handleLogin,
                            isLoading: _isLoading,
                          ),
                          
                          // Espaciado flexible para empujar el footer hacia abajo
                          const Spacer(),
                          
                          // Footer fijo con términos y "Rápido y Seguro"
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Términos y condiciones
                              Center(
                                child: Text(
                                  'Al iniciar sesión aceptas nuestros\ntérminos y condiciones',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color.fromARGB(255, 94, 65, 142),
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 40),
                              
                              // Texto Rápido y Seguro
                              Center(
                                child: Text(
                                  'Rápido y Seguro',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                    fontFamily: 'Roboto',
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 3,
                                    
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 50),
                            ],
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}