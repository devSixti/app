// Pantalla para subir la foto de verificación (selfie)

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/widgets/work_file_picker.dart';

class WorkVerificationSelfiePage extends StatefulWidget {
  const WorkVerificationSelfiePage({super.key, required this.vehicleType});

  final String vehicleType; // sufijo de almacenamiento (e.g., carro, moto, repartidor_moto)

  @override
  State<WorkVerificationSelfiePage> createState() => _WorkVerificationSelfiePageState();
}

class _WorkVerificationSelfiePageState extends State<WorkVerificationSelfiePage> {
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
            const WorkAppBar(title: 'Foto de verificación', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Para completar tu registro, debes subir una foto tuya donde se vea claramente tu rostro.',
                      style: TextStyle(color: AppTheme.whiteContainer, fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    WorkFilePicker(
                      label: 'Selfie (imagen)',
                      buttonLabel: 'Subir foto',
                      allowedExtensions: const ['png', 'jpg', 'jpeg', 'heic', 'heif', 'webp'],
                      onFileSelected: (file) {
                        setState(() {
                          _selfieName = file?.name;
                          _selfiePath = file?.path;
                        });
                      },
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
                          'Guardar y continuar',
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

  bool _validate() {
    if (_selfiePath == null || _selfiePath!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sube una foto de verificación para continuar')),
      );
      return false;
    }
    return true;
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'selfie_${widget.vehicleType}_';
    setState(() {
      _selfieName = prefs.getString('${prefix}name');
      _selfiePath = prefs.getString('${prefix}path');
    });
  }

  Future<void> _saveAndMarkCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = 'selfie_${widget.vehicleType}_';
    await prefs.setString('${prefix}name', _selfieName ?? '');
    await prefs.setString('${prefix}path', _selfiePath ?? '');
    await prefs.setBool('selfie_completed_${widget.vehicleType}', true);
  }
}
