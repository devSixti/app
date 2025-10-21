import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/work_in_xisti/widgets/work_app_bar.dart';
import 'package:app/ui/work_in_xisti/pages/work_basic_info_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_identity_document_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_judicial_background_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_bicycle_info_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_verification_selfie_page.dart';
import 'package:app/ui/work_in_xisti/pages/work_ready_page.dart';

class WorkDeliveryBikeRegisterPage extends StatefulWidget {
  const WorkDeliveryBikeRegisterPage({super.key, required this.storageKeySuffix});
  final String storageKeySuffix; // 'repartidor_bicicleta'

  @override
  State<WorkDeliveryBikeRegisterPage> createState() => _WorkDeliveryBikeRegisterPageState();
}

class _WorkDeliveryBikeRegisterPageState extends State<WorkDeliveryBikeRegisterPage> {
  bool _basicInfoCompleted = false;
  bool _identityCompleted = false;
  bool _backgroundCompleted = false;
  bool _bicycleCompleted = false;
  bool _selfieCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadBasicFlag();
    _loadIdentityFlag();
    _loadBackgroundFlag();
    _loadBicycleFlag();
    _loadSelfieFlag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScaffold,
      body: SafeArea(
        child: Column(
          children: [
            const WorkAppBar(title: 'Registro Repartidor', showBack: true),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final ok = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkBasicInfoPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (ok == true) setState(() => _basicInfoCompleted = true);
                      },
                      child: _buildItem('Información Básica', _basicInfoCompleted),
                    ),

                    GestureDetector(
                      onTap: () async {
                        final ok = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkIdentityDocumentPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (ok == true) setState(() => _identityCompleted = true);
                      },
                      child: _buildItem('Documento de Identidad', _identityCompleted),
                    ),

                    GestureDetector(
                      onTap: () async {
                        final ok = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkJudicialBackgroundPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (ok == true) setState(() => _backgroundCompleted = true);
                      },
                      child: _buildItem('Certificado de antecedentes', _backgroundCompleted),
                    ),

                    GestureDetector(
                      onTap: () async {
                        final ok = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkBicycleInfoPage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (ok == true) setState(() => _bicycleCompleted = true);
                      },
                      child: _buildItem('Información de bicicleta', _bicycleCompleted),
                    ),

                    GestureDetector(
                      onTap: () async {
                        final ok = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WorkVerificationSelfiePage(vehicleType: widget.storageKeySuffix),
                          ),
                        );
                        if (ok == true) setState(() => _selfieCompleted = true);
                      },
                      child: _buildItem('Foto de verificación', _selfieCompleted),
                    ),

                    const Spacer(),

                    Center(
                      child: ElevatedButton(
                        onPressed: _onContinue,
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
                    const SizedBox(height: 50),
                    Transform.translate(
                      offset: const Offset(0, -35),
                      child: Text(
                        'Al presionar “continuar”, acepto los Términos y condiciones de Xisti, además acepto el procesamiento y transferencia de datos personales según nuestra Política de privacidad',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppTheme.greyTextColor, fontSize: 12, height: 1.4),
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

  Widget _buildItem(String title, bool completed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: AppTheme.darkGreyContainer, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(color: AppTheme.whiteContainer, fontSize: 15)),
          ),
          Icon(completed ? Icons.check_circle : Icons.circle_outlined,
              color: completed ? AppTheme.primaryColor : AppTheme.whiteContainer.withOpacity(0.4), size: 22),
        ],
      ),
    );
  }

  void _onContinue() {
    final done = _basicInfoCompleted && _identityCompleted && _backgroundCompleted && _bicycleCompleted && _selfieCompleted;
    if (!done) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Completa todos los pasos antes de continuar')));
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WorkReadyPage()));
  }

  Future<void> _loadBasicFlag() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => _basicInfoCompleted = prefs.getBool('basic_info_completed_${widget.storageKeySuffix}') ?? false);
  }

  Future<void> _loadIdentityFlag() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => _identityCompleted = prefs.getBool('identity_completed_${widget.storageKeySuffix}') ?? false);
  }

  Future<void> _loadBackgroundFlag() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => _backgroundCompleted = prefs.getBool('background_completed_${widget.storageKeySuffix}') ?? false);
  }

  Future<void> _loadBicycleFlag() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => _bicycleCompleted = prefs.getBool('bicycle_completed_${widget.storageKeySuffix}') ?? false);
  }

  Future<void> _loadSelfieFlag() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => _selfieCompleted = prefs.getBool('selfie_completed_${widget.storageKeySuffix}') ?? false);
  }
}
