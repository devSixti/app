// Pantalla de Licencia de Conducción dentro del módulo "Trabaja en Xisti".
// Recoge y valida: Número de licencia, Categoría, Fecha de expedición y Fecha de vencimiento.
// Persiste durante la sesión mediante SharedPreferences y retorna "true" al completar para mostrar el chulito.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_dropdown_field.dart';
import 'package:app/ui/work_in_xisti/widgets/work_date_field.dart';
import 'package:app/ui/work_in_xisti/widgets/work_file_picker.dart';
 

class WorkLicensePage extends StatefulWidget {
  final String vehicleType; // Carro o Moto

  const WorkLicensePage({super.key, required this.vehicleType});

  @override
  State<WorkLicensePage> createState() => _WorkLicensePageState();
}

class _WorkLicensePageState extends State<WorkLicensePage> {
  // Controladores para inputs
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  // Archivo de licencia (PDF o imagen)
  String? _licenseDocName;
  String? _licenseDocPath;

  // Categorías de licencia comunes en Colombia
  final List<String> _categories = const [
    'A1', 'A2', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'
  ];
  String? _selectedCategory;

  // Reglas de entrada: número de licencia solo dígitos y máx 15 (ajustable)
  List<TextInputFormatter> get _numberFormatters => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(15), 
      ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior
            WorkAppBar(
              title: 'Licencia de conducción',
              showBack: true,
            ),

            // Contenido
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Número de licencia
                    _buildInputField(
                      controller: _licenseNumberController,
                      hint: 'Número de licencia',
                      keyboardType: TextInputType.number,
                      inputFormatters: _numberFormatters,
                    ),
                    const SizedBox(height: 14),

                    // Categoría de licencia
                    WorkDropdownField(
                      hint: 'Categoría de licencia',
                      items: _categories,
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() => _selectedCategory = value);
                      },
                    ),
                    const SizedBox(height: 14),

                    // Fecha de expedición (hasta hoy)
                    WorkDateField(
                      hint: 'Fecha de expedición',
                      controller: _issueDateController,
                      lastDate: DateTime.now(),
                    ),
                    const SizedBox(height: 14),

                    // Fecha de vencimiento (desde hoy en adelante, hasta 2100)
                    WorkDateField(
                      hint: 'Fecha de vencimiento',
                      controller: _expiryDateController,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    ),
                    const SizedBox(height: 14),

                    // Adjuntar copia de la licencia (PDF o imagen)
                    WorkFilePicker(
                      label: 'Licencia (PDF o imagen)',
                      onFileSelected: (file) {
                        setState(() {
                          _licenseDocName = file?.name;
                          _licenseDocPath = file?.path;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // Botón Continuar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_validateForm()) return;
                          await _saveDataAndMarkCompleted();
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

  // Construye un TextField con el mismo estilo del módulo
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(color: AppTheme.whiteContainer),
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

  // Validación del formulario
  bool _validateForm() {
    if (_licenseNumberController.text.trim().isEmpty) {
      _showSnack('Ingresa el número de licencia');
      return false;
    }
    // Validación: solo dígitos (1 a 15). El input ya limita a 15, aquí reforzamos.
    final licNum = _licenseNumberController.text.trim();
    if (!RegExp(r'^\d{1,15}$').hasMatch(licNum)) {
      _showSnack('El número de licencia debe tener máximo 15 dígitos');
      return false;
    }
    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      _showSnack('Selecciona la categoría de licencia');
      return false;
    }
    if (_issueDateController.text.trim().isEmpty) {
      _showSnack('Selecciona la fecha de expedición');
      return false;
    }
    if (_expiryDateController.text.trim().isEmpty) {
      _showSnack('Selecciona la fecha de vencimiento');
      return false;
    }
    if (_licenseDocPath == null || _licenseDocPath!.isEmpty) {
      _showSnack('Sube tu licencia (PDF o imagen) para continuar');
      return false;
    }
    return true;
  }

  // Snack helper
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // Carga datos guardados (durante la sesión)
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'license_${widget.vehicleType}_';
    setState(() {
      _selectedCategory = prefs.getString('${prefix}category');
      _licenseNumberController.text = prefs.getString('${prefix}number') ?? '';
      _issueDateController.text = prefs.getString('${prefix}issueDate') ?? '';
      _expiryDateController.text = prefs.getString('${prefix}expiryDate') ?? '';
      _licenseDocName = prefs.getString('${prefix}docName');
      _licenseDocPath = prefs.getString('${prefix}docPath');
    });
  }

  // Guarda datos y marca como completado (para el chulito)
  Future<void> _saveDataAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'license_${widget.vehicleType}_';
    await prefs.setString('${prefix}number', _licenseNumberController.text.trim());
    await prefs.setString('${prefix}category', _selectedCategory ?? '');
    await prefs.setString('${prefix}issueDate', _issueDateController.text.trim());
    await prefs.setString('${prefix}expiryDate', _expiryDateController.text.trim());
    await prefs.setString('${prefix}docName', _licenseDocName ?? '');
    await prefs.setString('${prefix}docPath', _licenseDocPath ?? '');
    await prefs.setBool('license_completed_${widget.vehicleType}', true);
  }
}
