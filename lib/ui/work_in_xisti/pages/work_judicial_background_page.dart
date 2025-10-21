// Pantalla de Antecedentes Judiciales dentro del módulo "Trabaja en Xisti".
// Muestra instrucciones, enlace oficial y permite subir el certificado en PDF.
// Persiste durante la sesión (SharedPreferences) y retorna true al completar para el chulito.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkJudicialBackgroundPage extends StatefulWidget {
  final String vehicleType; // Carro o Moto

  const WorkJudicialBackgroundPage({super.key, required this.vehicleType});

  @override
  State<WorkJudicialBackgroundPage> createState() => _WorkJudicialBackgroundPageState();
}

class _WorkJudicialBackgroundPageState extends State<WorkJudicialBackgroundPage> {
  // Estado mínimo: nombre y ruta del PDF seleccionado
  String? _pdfName;
  String? _pdfPath;
  // Selfie de verificación (opcional)
  String? _selfieName;
  String? _selfiePath;

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
              title: 'Antecedentes judiciales',
              showBack: true,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mensaje informativo
                    Text(
                      'Para continuar con tu registro como conductor, debes obtener tu certificado de antecedentes judiciales.\n\n'
                      'Puedes descargarlo fácilmente desde la aplicación oficial de la Policía Nacional o en el siguiente enlace:',
                      style: TextStyle(color: AppTheme.whiteContainer, fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 10),

                    // Enlace oficial
                    InkWell(
                      onTap: () => _openUrl('https://antecedentes.policia.gov.co:7005/WebJudicial/'),
                      child: Text(
                        'https://antecedentes.policia.gov.co:7005/WebJudicial/',
                        style: TextStyle(color: AppTheme.primaryColor, decoration: TextDecoration.underline),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Selector de PDF reutilizable
                    WorkFilePicker(
                      label: 'Certificado en PDF',
                      onFileSelected: (file) {
                        setState(() {
                          _pdfName = file?.name;
                          _pdfPath = file?.path;
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

  // Validación: requiere que exista un PDF seleccionado
  bool _validateForm() {
    if (_pdfPath == null || _pdfPath!.isEmpty) {
      _showSnack('Sube tu certificado en PDF para continuar');
      return false;
    }
    return true;
  }

  // Helper para abrir URL
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _showSnack('No se pudo abrir el enlace');
    }
  }

  // Snack helper
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // Carga guardado durante sesión
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'background_${widget.vehicleType}_';
    setState(() {
      _pdfName = prefs.getString('${prefix}pdfName');
      _pdfPath = prefs.getString('${prefix}pdfPath');
      _selfieName = prefs.getString('${prefix}selfieName');
      _selfiePath = prefs.getString('${prefix}selfiePath');
    });
  }

  // Guarda y marca completado para el chulito
  Future<void> _saveDataAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'background_${widget.vehicleType}_';
    await prefs.setString('${prefix}pdfName', _pdfName ?? '');
    await prefs.setString('${prefix}pdfPath', _pdfPath ?? '');
    await prefs.setString('${prefix}selfieName', _selfieName ?? '');
    await prefs.setString('${prefix}selfiePath', _selfiePath ?? '');
    await prefs.setBool('background_completed_${widget.vehicleType}', true);
  }
}
