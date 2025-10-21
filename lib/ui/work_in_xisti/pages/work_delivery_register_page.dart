// Registro para Repartidor (carro o moto), reutiliza las mismas secciones del flujo de Conductor
// pero separa la persistencia usando un sufijo de almacenamiento distinto (e.g., 'delivery_carro').

import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/pages/work_basic_info_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_identity_document_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_judicial_background_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_license_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_soat_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_vehicle_info_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_ready_page.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/pages/work_verification_selfie_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkDeliveryRegisterPage extends StatefulWidget {
  const WorkDeliveryRegisterPage({
    super.key,
    required this.vehicleTypeLabel, // 'carro' | 'moto'
    required this.storageKeySuffix, // 'delivery_carro' | 'delivery_moto'
  });

  final String vehicleTypeLabel;
  final String storageKeySuffix;

  @override
  State<WorkDeliveryRegisterPage> createState() => _WorkDeliveryRegisterPageState();
}

class _WorkDeliveryRegisterPageState extends State<WorkDeliveryRegisterPage> {
  bool _basicInfoCompleted = false;
  bool _identityCompleted = false;
  bool _licenseCompleted = false;
  bool _backgroundCompleted = false;
  bool _soatCompleted = false;
  bool _vehicleCompleted = false;
  bool _selfieCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadCompletionFlag();
    _loadIdentityFlag();
    _loadLicenseFlag();
    _loadBackgroundFlag();
    _loadSoatFlag();
    _loadVehicleFlag();
    _loadSelfieFlag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            WorkAppBar(
              title: 'Registro Repartidor',
              showBack: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkBasicInfoPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (completed == true) setState(() => _basicInfoCompleted = true);
                      },
                      child: _buildRegisterItem('Información Básica', completed: _basicInfoCompleted),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkIdentityDocumentPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (completed == true) setState(() => _identityCompleted = true);
                      },
                      child: _buildRegisterItem('Documento de Identidad', completed: _identityCompleted),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkLicensePage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (completed == true) setState(() => _licenseCompleted = true);
                      },
                      child: _buildRegisterItem('Licencia', completed: _licenseCompleted),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkJudicialBackgroundPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (completed == true) setState(() => _backgroundCompleted = true);
                      },
                      child: _buildRegisterItem('Certificado de antecedentes', completed: _backgroundCompleted),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkSoatPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (completed == true) setState(() => _soatCompleted = true);
                      },
                      child: _buildRegisterItem('SOAT', completed: _soatCompleted),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkVehicleInfoPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (completed == true) setState(() => _vehicleCompleted = true);
                      },
                      child: _buildRegisterItem('Información de vehículo', completed: _vehicleCompleted),
                    ),

                    GestureDetector(
                      onTap: () async {
                        final completed = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkVerificationSelfiePage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (completed == true) setState(() => _selfieCompleted = true);
                      },
                      child: _buildRegisterItem('Foto de verificación', completed: _selfieCompleted),
                    ),

                    const Spacer(),

                    Center(
                      child: ElevatedButton(
                        onPressed: _onContinuePressed,
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

                    const SizedBox(height: 50),

                    Transform.translate(
                      offset: const Offset(0, -35),
                      child: Text(
                        'Al presionar “continuar”, acepto los Términos y condiciones de Xisti, además acepto el procesamiento y transferencia de datos personales según nuestra Política de privacidad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.greyTextColor,
                          fontSize: 12,
                          height: 1.4,
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

  static Widget _buildRegisterItem(String title, {bool completed = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: AppTheme.whiteContainer, fontSize: 15),
            ),
          ),
          Icon(
            completed ? Icons.check_circle : Icons.circle_outlined,
            color: completed ? AppTheme.primaryColor : AppTheme.whiteContainer.withOpacity(0.4),
            size: 22,
          ),
        ],
      ),
    );
  }

  Future<void> _loadCompletionFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('basic_info_completed_${widget.storageKeySuffix}') ?? false;
    if (mounted) setState(() => _basicInfoCompleted = saved);
  }

  Future<void> _loadIdentityFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('identity_completed_${widget.storageKeySuffix}') ?? false;
    if (mounted) setState(() => _identityCompleted = saved);
  }

  Future<void> _loadLicenseFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('license_completed_${widget.storageKeySuffix}') ?? false;
    if (mounted) setState(() => _licenseCompleted = saved);
  }

  Future<void> _loadBackgroundFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('background_completed_${widget.storageKeySuffix}') ?? false;
    if (mounted) setState(() => _backgroundCompleted = saved);
  }

  Future<void> _loadSoatFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('soat_completed_${widget.storageKeySuffix}') ?? false;
    if (mounted) setState(() => _soatCompleted = saved);
  }

  Future<void> _loadVehicleFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('vehicle_completed_${widget.storageKeySuffix}') ?? false;
    if (mounted) setState(() => _vehicleCompleted = saved);
  }

  void _onContinuePressed() {
    final allDone = _basicInfoCompleted &&
        _identityCompleted &&
        _licenseCompleted &&
        _backgroundCompleted &&
        _soatCompleted &&
        _vehicleCompleted &&
        _selfieCompleted;
    if (!allDone) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los pasos antes de continuar')),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const WorkReadyPage()),
    );
  }

  Future<void> _loadSelfieFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool('selfie_completed_${widget.storageKeySuffix}') ?? false;
    if (mounted) setState(() => _selfieCompleted = saved);
  }
}
