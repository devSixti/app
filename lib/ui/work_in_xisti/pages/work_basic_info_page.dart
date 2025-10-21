// Pantalla de Información Básica del conductor dentro del módulo "Trabaja en Xisti".
// Permite al conductor ingresar sus datos personales y de contacto antes de continuar con el registro.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/ui/work_in_xisti/widgets/work_date_field.dart';
 
import 'package:app/ui/work_in_xisti/widgets/work_dropdown_field.dart';

class WorkBasicInfoPage extends StatefulWidget {
  final String vehicleType; // Carro o Moto

  const WorkBasicInfoPage({super.key, required this.vehicleType});

  @override
  State<WorkBasicInfoPage> createState() => _WorkBasicInfoPageState();
}

class _WorkBasicInfoPageState extends State<WorkBasicInfoPage> {
  // Controladores para los campos de texto
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _secondLastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otherGenderController = TextEditingController();

  String? _selectedGender;

 

  // Lista de géneros disponibles
  final List<String> _genders = [
    'Masculino',
    'Femenino',
    'Otro',
  ];

  @override
  void initState() {
    super.initState();
    // Al abrir, intentamos cargar información previa guardada para este tipo de vehículo.
    _loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior con título y botón regresar
            WorkAppBar(
              title: 'Información Básica',
              showBack: true,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    _buildInputField(
                      controller: _firstNameController,
                      hint: 'Primer nombre',
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-zÁÉÍÓÚáéíóúÑñ]'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    _buildInputField(
                      controller: _middleNameController,
                      hint: 'Segundo nombre (opcional)',
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-zÁÉÍÓÚáéíóúÑñ]'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    _buildInputField(
                      controller: _lastNameController,
                      hint: 'Primer apellido',
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-zÁÉÍÓÚáéíóúÑñ]'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    _buildInputField(
                      controller: _secondLastNameController,
                      hint: 'Segundo apellido',
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-zÁÉÍÓÚáéíóúÑñ]'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Fecha de nacimiento
                    WorkDateField(
                      hint: 'Fecha de nacimiento',
                      controller: _birthDateController,
                    ),
                    const SizedBox(height: 14),

                    // Correo electrónico
                    _buildInputField(
                      controller: _emailController,
                      hint: 'Correo electrónico',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),

                    // Número de teléfono
                    // Solo números y máximo 10 dígitos para teléfono
                    _buildInputField(
                      controller: _phoneController,
                      hint: 'Número de teléfono',
                      keyboardType: TextInputType.phone,
                      // Prefijo con bandera y código de país, siempre visible
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('🇨🇴', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 6),
                            Text('+57', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      // Formateadores: permite solo dígitos y limita a 10
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Género
                    WorkDropdownField(
                      hint: 'Sexo',
                      items: _genders,
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() => _selectedGender = value);
                      },
                    ),
                    if (_selectedGender == 'Otro') const SizedBox(height: 14),
                    if (_selectedGender == 'Otro')
                      _buildInputField(
                        controller: _otherGenderController,
                        hint: 'Especifica otro',
                        keyboardType: TextInputType.text,
                      ),
                    const SizedBox(height: 30),

 

                    // Botón Continuar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validación antes de guardar
                          if (!_validateForm()) return;
                          await _saveDataAndMarkCompleted();
                          // Retorna true al panel de registro indicando que se completó la información básica
                          // ignore: use_build_context_synchronously
                          if (mounted) Navigator.pop(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Continuar',
                          style: TextStyle(
                            color: AppTheme.blackContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construye un campo de texto
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool readOnly = false,
    void Function()? onTap,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Widget? prefix,
    // Permite pasar formateadores de entrada (por ejemplo: solo dígitos, límite de longitud)
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(color: AppTheme.whiteContainer),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.greyTextColor),
        filled: true,
        fillColor: AppTheme.darkGreyContainer,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefix: prefix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
      ),
    );
  }

  // Carga datos guardados previamente para el vehicleType actual.
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'basic_info_${widget.vehicleType}_';

    _firstNameController.text = prefs.getString('${prefix}firstName') ?? '';
    _middleNameController.text = prefs.getString('${prefix}middleName') ?? '';
    _lastNameController.text = prefs.getString('${prefix}lastName') ?? '';
    _secondLastNameController.text = prefs.getString('${prefix}secondLastName') ?? '';
    _birthDateController.text = prefs.getString('${prefix}birthDate') ?? '';
    _emailController.text = prefs.getString('${prefix}email') ?? '';
    _phoneController.text = prefs.getString('${prefix}phone') ?? '';
    _otherGenderController.text = prefs.getString('${prefix}otherGender') ?? '';
    setState(() {
      final savedGender = prefs.getString('${prefix}gender');
      _selectedGender = (savedGender != null && savedGender.isNotEmpty && _genders.contains(savedGender))
          ? savedGender
          : null;
 
    });
  }

  // Guarda los datos actuales del formulario y marca el paso como completado de forma persistente.
  Future<void> _saveDataAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'basic_info_${widget.vehicleType}_';
    // Guardar datos del formulario
    await prefs.setString('${prefix}firstName', _firstNameController.text.trim());
    await prefs.setString('${prefix}middleName', _middleNameController.text.trim());
    await prefs.setString('${prefix}lastName', _lastNameController.text.trim());
    await prefs.setString('${prefix}secondLastName', _secondLastNameController.text.trim());
    await prefs.setString('${prefix}birthDate', _birthDateController.text.trim());
    await prefs.setString('${prefix}email', _emailController.text.trim());
    await prefs.setString('${prefix}phone', _phoneController.text.trim());
    await prefs.setString('${prefix}gender', _selectedGender ?? '');
    await prefs.setString('${prefix}otherGender', _otherGenderController.text.trim());
 
    // Marcar completado para este tipo de vehículo
    await prefs.setBool('basic_info_completed_${widget.vehicleType}', true);
  }

  // Validaciones de formulario según lo solicitado
  bool _validateForm() {
    final nameRegex = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ]+$');

    final firstName = _firstNameController.text.trim();
    if (firstName.isEmpty || !nameRegex.hasMatch(firstName)) {
      _showSnack('El primer nombre debe contener solo letras, sin espacios.');
      return false;
    }

    final middleName = _middleNameController.text.trim();
    if (middleName.isNotEmpty && !nameRegex.hasMatch(middleName)) {
      _showSnack('El segundo nombre (opcional) solo puede tener letras, sin espacios.');
      return false;
    }

    final lastName = _lastNameController.text.trim();
    if (lastName.isEmpty || !nameRegex.hasMatch(lastName)) {
      _showSnack('El primer apellido debe contener solo letras, sin espacios.');
      return false;
    }

    final secondLastName = _secondLastNameController.text.trim();
    if (secondLastName.isNotEmpty && !nameRegex.hasMatch(secondLastName)) {
      _showSnack('El segundo apellido debe contener solo letras, sin espacios.');
      return false;
    }

    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      _showSnack('Ingresa un correo válido que contenga @');
      return false;
    }

    final phone = _phoneController.text.trim();
    if (phone.length != 10) {
      _showSnack('El teléfono debe tener 10 dígitos');
      return false;
    }

    return true;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
  