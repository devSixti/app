// Pantalla de SOAT dentro del módulo "Trabaja en Xisti".
// Muestra instrucciones y permite subir el comprobante vigente (PDF o imagen) con WorkFilePicker.
// Persiste durante la sesión (SharedPreferences) y retorna true al completar para el chulito.

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkSoatPage extends StatefulWidget {
  final String vehicleType; // Carro o Moto

  const WorkSoatPage({super.key, required this.vehicleType});

  @override
  State<WorkSoatPage> createState() => _WorkSoatPageState();
}

class _WorkSoatPageState extends State<WorkSoatPage> {
  String? _fileName;
  String? _filePath;

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
              title: 'SOAT',
              showBack: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Para continuar con tu registro como conductor, debes subir el comprobante'
                      'de tu SOAT vigente.',
                      style: TextStyle(color: AppTheme.whiteContainer, fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 24),

                    WorkFilePicker(
                      label: 'Comprobante (PDF o imagen)',
                      onFileSelected: (file) {
                        setState(() {
                          _fileName = file?.name;
                          _filePath = file?.path;
                        });
                      },
                    ),

                    const SizedBox(height: 30),
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

  bool _validateForm() {
    if (_filePath == null || _filePath!.isEmpty) {
      _showSnack('Sube el comprobante de tu SOAT para continuar');
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
    final prefix = 'soat_${widget.vehicleType}_';
    setState(() {
      _fileName = prefs.getString('${prefix}fileName');
      _filePath = prefs.getString('${prefix}filePath');
    });
  }

  Future<void> _saveDataAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'soat_${widget.vehicleType}_';
    await prefs.setString('${prefix}fileName', _fileName ?? '');
    await prefs.setString('${prefix}filePath', _filePath ?? '');
    await prefs.setBool('soat_completed_${widget.vehicleType}', true);
  }
}
