// Pantalla de Información del vehículo dentro del módulo "Trabaja en Xisti".
// Campos: Tipo de vehículo, Marca, Modelo, Año, Color, Placa y Foto del vehículo.
// Persiste durante la sesión (SharedPreferences) y retorna true al completar para el chulito.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_dropdown_field.dart';
import 'package:app/ui/work_in_xisti/widgets/work_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkVehicleInfoPage extends StatefulWidget {
  final String vehicleType; // Carro o Moto (flujo)

  const WorkVehicleInfoPage({super.key, required this.vehicleType});

  @override
  State<WorkVehicleInfoPage> createState() => _WorkVehicleInfoPageState();
}

class _WorkVehicleInfoPageState extends State<WorkVehicleInfoPage> {
  // Dropdown tipo de vehículo interno (puede diferir del flujo si se requiere)
  final List<String> _vehicleTypes = const ['Carro', 'Moto'];
  String? _selectedType;

  // Inputs de texto
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();

  // Foto
  String? _photoName;
  String? _photoPath;

  // Formateadores
  List<TextInputFormatter> get _yearFormatters => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
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
            WorkAppBar(
              title: 'Información del vehículo',
              showBack: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Tipo de vehículo (dropdown)
                    WorkDropdownField(
                      hint: 'Tipo de vehículo',
                      items: _vehicleTypes,
                      value: _selectedType,
                      onChanged: (val) => setState(() => _selectedType = val),
                    ),
                    const SizedBox(height: 14),

                    // Marca
                    _buildInputField(controller: _brandController, hint: 'Marca'),
                    const SizedBox(height: 14),

                    // Modelo
                    _buildInputField(controller: _modelController, hint: 'Modelo'),
                    const SizedBox(height: 14),

                    // Año
                    _buildInputField(
                      controller: _yearController,
                      hint: 'Año',
                      keyboardType: TextInputType.number,
                      inputFormatters: _yearFormatters,
                    ),
                    const SizedBox(height: 14),

                    // Color
                    _buildInputField(controller: _colorController, hint: 'Color'),
                    const SizedBox(height: 14),

                    // Placa
                    _buildInputField(controller: _plateController, hint: 'Placa'),
                    const SizedBox(height: 14),

                    // Foto del vehículo (imagen o pdf si el usuario insiste, pero se sugiere imagen)
                    WorkFilePicker(
                      label: 'Foto del vehículo (imagen)',
                      onFileSelected: (file) {
                        setState(() {
                          _photoName = file?.name;
                          _photoPath = file?.path;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

  // Valida que los campos estén completos y el año tenga sentido
  bool _validateForm() {
    if (_selectedType == null || _selectedType!.isEmpty) {
      _showSnack('Selecciona el tipo de vehículo');
      return false;
    }
    if (_brandController.text.trim().isEmpty) {
      _showSnack('Ingresa la marca');
      return false;
    }
    if (_modelController.text.trim().isEmpty) {
      _showSnack('Ingresa el modelo');
      return false;
    }
    final yearStr = _yearController.text.trim();
    if (yearStr.isEmpty) {
      _showSnack('Ingresa el año');
      return false;
    }
    final int? year = int.tryParse(yearStr);
    final int currentYear = DateTime.now().year;
    if (year == null || year < 1970 || year > currentYear + 1) {
      _showSnack('Ingresa un año válido (1970 - ${currentYear + 1})');
      return false;
    }
    if (_colorController.text.trim().isEmpty) {
      _showSnack('Ingresa el color');
      return false;
    }
    if (_plateController.text.trim().isEmpty) {
      _showSnack('Ingresa la placa');
      return false;
    }
    if (_photoPath == null || _photoPath!.isEmpty) {
      _showSnack('Sube una foto del vehículo');
      return false;
    }
    return true;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // Entrada de texto consistente
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

  // Persistencia temporal
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'vehicle_${widget.vehicleType}_';
    setState(() {
      _selectedType = prefs.getString('${prefix}type');
      _brandController.text = prefs.getString('${prefix}brand') ?? '';
      _modelController.text = prefs.getString('${prefix}model') ?? '';
      _yearController.text = prefs.getString('${prefix}year') ?? '';
      _colorController.text = prefs.getString('${prefix}color') ?? '';
      _plateController.text = prefs.getString('${prefix}plate') ?? '';
      _photoName = prefs.getString('${prefix}photoName');
      _photoPath = prefs.getString('${prefix}photoPath');
    });
  }

  Future<void> _saveDataAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'vehicle_${widget.vehicleType}_';
    await prefs.setString('${prefix}type', _selectedType ?? '');
    await prefs.setString('${prefix}brand', _brandController.text.trim());
    await prefs.setString('${prefix}model', _modelController.text.trim());
    await prefs.setString('${prefix}year', _yearController.text.trim());
    await prefs.setString('${prefix}color', _colorController.text.trim());
    await prefs.setString('${prefix}plate', _plateController.text.trim());
    await prefs.setString('${prefix}photoName', _photoName ?? '');
    await prefs.setString('${prefix}photoPath', _photoPath ?? '');
    await prefs.setBool('vehicle_completed_${widget.vehicleType}', true);
  }
}
