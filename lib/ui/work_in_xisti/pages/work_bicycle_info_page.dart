// Información de Bicicleta para repartidor

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_dropdown_field.dart';
import 'package:app/ui/work_in_xisti/widgets/work_file_picker.dart';

class WorkBicycleInfoPage extends StatefulWidget {
  const WorkBicycleInfoPage({super.key, required this.vehicleType});
  final String vehicleType; // sufijo de almacenamiento (repartidor_bicicleta)

  @override
  State<WorkBicycleInfoPage> createState() => _WorkBicycleInfoPageState();
}

class _WorkBicycleInfoPageState extends State<WorkBicycleInfoPage> {
  final List<String> _bikeTypes = const ['Urbana', 'Ruta', 'Montaña'];
  String? _selectedType;

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _serialController = TextEditingController();

  String? _photoName;
  String? _photoPath;

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
            const WorkAppBar(title: 'Información de bicicleta', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    WorkDropdownField(
                      hint: 'Tipo de bicicleta',
                      items: _bikeTypes,
                      value: _selectedType,
                      onChanged: (v) => setState(() => _selectedType = v),
                    ),
                    const SizedBox(height: 14),

                    _buildInputField(controller: _brandController, hint: 'Marca'),
                    const SizedBox(height: 14),
                    _buildInputField(controller: _modelController, hint: 'Modelo'),
                    const SizedBox(height: 14),
                    _buildInputField(controller: _colorController, hint: 'Color'),
                    const SizedBox(height: 14),
                    _buildInputField(
                      controller: _serialController,
                      hint: 'Número de serie (opcional)',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 14),

                    WorkFilePicker(
                      label: 'Foto de la bicicleta (imagen)',
                      onFileSelected: (file) {
                        setState(() {
                          _photoName = file?.name;
                          _photoPath = file?.path;
                        });
                      },
                      buttonLabel: 'Subir foto',
                      allowedExtensions: const ['png', 'jpg', 'jpeg', 'heic', 'heif', 'webp'],
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_validate()) return;
                          await _saveAndMarkCompleted();
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
                          style: TextStyle(color: AppTheme.blackContainer, fontWeight: FontWeight.w600, fontSize: 16),
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
      ),
    );
  }

  bool _validate() {
    if (_selectedType == null || _selectedType!.isEmpty) {
      _show('Selecciona el tipo de bicicleta');
      return false;
    }
    if (_brandController.text.trim().isEmpty) {
      _show('Ingresa la marca');
      return false;
    }
    if (_modelController.text.trim().isEmpty) {
      _show('Ingresa el modelo');
      return false;
    }
    if (_colorController.text.trim().isEmpty) {
      _show('Ingresa el color');
      return false;
    }
    if (_photoPath == null || _photoPath!.isEmpty) {
      _show('Sube una foto de la bicicleta');
      return false;
    }
    return true;
  }

  void _show(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'bicycle_${widget.vehicleType}_';
    setState(() {
      _selectedType = prefs.getString('${prefix}type');
      _brandController.text = prefs.getString('${prefix}brand') ?? '';
      _modelController.text = prefs.getString('${prefix}model') ?? '';
      _colorController.text = prefs.getString('${prefix}color') ?? '';
      _serialController.text = prefs.getString('${prefix}serial') ?? '';
      _photoName = prefs.getString('${prefix}photoName');
      _photoPath = prefs.getString('${prefix}photoPath');
    });
  }

  Future<void> _saveAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'bicycle_${widget.vehicleType}_';
    await prefs.setString('${prefix}type', _selectedType ?? '');
    await prefs.setString('${prefix}brand', _brandController.text.trim());
    await prefs.setString('${prefix}model', _modelController.text.trim());
    await prefs.setString('${prefix}color', _colorController.text.trim());
    await prefs.setString('${prefix}serial', _serialController.text.trim());
    await prefs.setString('${prefix}photoName', _photoName ?? '');
    await prefs.setString('${prefix}photoPath', _photoPath ?? '');
    await prefs.setBool('bicycle_completed_${widget.vehicleType}', true);
  }
}
