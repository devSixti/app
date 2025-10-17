// Pantalla de Información Básica del conductor dentro del módulo "Trabaja en Xisti".
// Permite al conductor ingresar sus datos personales y de contacto antes de continuar con el registro.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior con título y botón regresar
            WorkAppBar(
              title: 'Información Básica (${widget.vehicleType})',
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
                    ),
                    const SizedBox(height: 14),

                    _buildInputField(
                      controller: _middleNameController,
                      hint: 'Segundo nombre (opcional)',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 14),

                    _buildInputField(
                      controller: _lastNameController,
                      hint: 'Primer apellido',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 14),

                    _buildInputField(
                      controller: _secondLastNameController,
                      hint: 'Segundo apellido (opcional)',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 14),

                    // Fecha de nacimiento
                    _buildInputField(
                      controller: _birthDateController,
                      hint: 'Fecha de nacimiento',
                      readOnly: true,
                      onTap: _selectDate,
                      suffixIcon: Icon(Icons.calendar_today_rounded, color: AppTheme.greyTextColor),
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
                    _buildInputField(
                      controller: _phoneController,
                      hint: 'Número de teléfono',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),

                    // Género
                    _buildDropdownField(
                      hint: 'Género',
                      value: _selectedGender,
                      items: _genders,
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
                        onPressed: () {
                          // Retorna true al panel de registro indicando que se completó la información básica
                          Navigator.pop(context, true);
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
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(color: AppTheme.whiteContainer),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.greyTextColor),
        filled: true,
        fillColor: AppTheme.darkGreyContainer,
        suffixIcon: suffixIcon,
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

  // Construye un campo Dropdown
  Widget _buildDropdownField({
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
    String? value,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppTheme.greyTextColor),
        filled: true,
        fillColor: AppTheme.darkGreyContainer,
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
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppTheme.greyTextColor),
      dropdownColor: AppTheme.darkGreyContainer,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: TextStyle(color: AppTheme.whiteContainer)),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  // Selector de fecha de nacimiento
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppTheme.primaryColor,
              onSurface: AppTheme.whiteContainer,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = DateFormat('dd/MM/yyyy', 'es_ES').format(picked);
      });
    }
  }
}
