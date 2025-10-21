import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_dropdown_field.dart';
import 'package:app/ui/work_in_xisti/widgets/work_date_field.dart';

class WorkIdentityDocumentPage extends StatefulWidget {
  final String vehicleType; // Carro o Moto

  const WorkIdentityDocumentPage({super.key, required this.vehicleType});

  @override
  State<WorkIdentityDocumentPage> createState() => _WorkIdentityDocumentPageState();
}

class _WorkIdentityDocumentPageState extends State<WorkIdentityDocumentPage> {
  // Controladores
  final TextEditingController _docNumberController = TextEditingController();
  final TextEditingController _issuePlaceController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();

  // Tipo de documento
  final List<String> _docTypes = const [
    'Cédula de ciudadanía',
    'Cédula de extranjería',
    'Pasaporte',
  ];
  String? _selectedDocType;

  // Reglas de entrada para C.C.
  List<TextInputFormatter> get _ccFormatters => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
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
              title: 'Documento de Identidad (${widget.vehicleType})',
              showBack: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Tipo de documento
                    WorkDropdownField(
                      hint: 'Tipo de documento',
                      items: _docTypes,
                      value: _selectedDocType,
                      onChanged: (value) {
                        setState(() {
                          _selectedDocType = value;
                          // Limpiar número si cambia tipo
                          _docNumberController.clear();
                        });
                      },
                    ),
                    const SizedBox(height: 14),

                    // Número de documento (C.C. solo dígitos y máx 10)
                    _buildInputField(
                      controller: _docNumberController,
                      hint: 'Número de documento',
                      keyboardType: TextInputType.number,
                      inputFormatters:
                          _selectedDocType == 'Cédula de ciudadanía' ? _ccFormatters : null,
                    ),
                    const SizedBox(height: 14),

                    // Lugar de expedición
                    _buildInputField(
                      controller: _issuePlaceController,
                      hint: 'Lugar de expedición',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 14),

                    // Fecha de expedición
                    WorkDateField(
                      hint: 'Fecha de expedición',
                      controller: _issueDateController,
                      // Permite fechas hasta hoy
                      lastDate: DateTime.now(),
                    ),
                    const SizedBox(height: 30),

                    // Botón Guardar / Continuar
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

  bool _validateForm() {
    if (_selectedDocType == null || _selectedDocType!.isEmpty) {
      _showSnack('Selecciona el tipo de documento');
      return false;
    }
    if (_docNumberController.text.trim().isEmpty) {
      _showSnack('Ingresa el número de documento');
      return false;
    }
    if (_selectedDocType == 'Cédula de ciudadanía (C.C.)') {
      final num = _docNumberController.text.trim();
      if (!RegExp(r'^\d{6,10}$').hasMatch(num)) {
        _showSnack('La C.C. debe tener entre 6 y 10 dígitos');
        return false;
      }
    }
    if (_issuePlaceController.text.trim().isEmpty) {
      _showSnack('Ingresa el lugar de expedición');
      return false;
    }
    if (_issueDateController.text.trim().isEmpty) {
      _showSnack('Selecciona la fecha de expedición');
      return false;
    }
    return true;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'identity_${widget.vehicleType}_';
    setState(() {
      _selectedDocType = prefs.getString('${prefix}type');
      _docNumberController.text = prefs.getString('${prefix}number') ?? '';
      _issuePlaceController.text = prefs.getString('${prefix}place') ?? '';
      _issueDateController.text = prefs.getString('${prefix}date') ?? '';
    });
  }

  Future<void> _saveDataAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'identity_${widget.vehicleType}_';
    await prefs.setString('${prefix}type', _selectedDocType ?? '');
    await prefs.setString('${prefix}number', _docNumberController.text.trim());
    await prefs.setString('${prefix}place', _issuePlaceController.text.trim());
    await prefs.setString('${prefix}date', _issueDateController.text.trim());
    await prefs.setBool('identity_completed_${widget.vehicleType}', true);
  }
}
