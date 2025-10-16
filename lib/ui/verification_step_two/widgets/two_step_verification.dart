import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'parts/method_choice_widget.dart';
import 'parts/contact_input_card.dart';
import 'parts/verification_code_card.dart';

enum MethodType { sms, email }

class TwoStepVerificationScreen extends StatefulWidget {
  const TwoStepVerificationScreen({super.key});
  @override
  State<TwoStepVerificationScreen> createState() => _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
  MethodType _method = MethodType.sms;
  final TextEditingController _contactController = TextEditingController();
  bool _sent = false;
  bool _verified = false;
  bool _canEdit = true; // la vista debe mostrarse editable para pruebas
  int _secondsLeft = 0;

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  void _sendCode() {
    // No enviamos código real: solo simulamos que se envió para mostrar la UI
    if (!_canEdit) return;
    if (_contactController.text.trim().isEmpty) return;
  // Ocultar el teclado / desenfocar el campo activo (evita conflicto con el teclado)
  FocusScope.of(context).unfocus();
  // hide keyboard explicitly (más robusto en algunos dispositivos)
  SystemChannels.textInput.invokeMethod('TextInput.hide');

    setState(() {
      _sent = true;
      _verified = false;
      _secondsLeft = 30; // simulamos cooldown corto
    });
  }

  void _onCompleteCode(String code) {
    // Sólo UI: marcar verificado cuando el usuario complete 6 dígitos
    setState(() => _verified = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkGreyContainer,
        elevation: 0,
        title: const Text('Verificación en Dos Pasos', style: TextStyle(color: AppTheme.whiteContainer)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 8),

            Row(
              children: [
                Switch(
                  value: _canEdit,
                      activeColor: AppTheme.purpleColor,
                  inactiveThumbColor: AppTheme.whiteContainer,
                  inactiveTrackColor: AppTheme.darkGreyContainer,
                  onChanged: (val) {
                    setState(() {
                      _canEdit = val;
                      if (!_canEdit) {
                        _contactController.clear();
                        _sent = false;
                        _verified = false;
                        _secondsLeft = 0;
                        FocusScope.of(context).unfocus();
                      }
                    });
                  },
                ),
                const SizedBox(width: 8),
                    Text(_canEdit ? 'Activado' : 'Desactivado', style: TextStyle(color: _canEdit ? AppTheme.purpleColor : AppTheme.lightGreyContainer, fontWeight: FontWeight.w700)),
              ],
            ),

            // Paso 1: método
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.inputBackgroundDark, borderRadius: AppTheme.border), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(radius: 18, backgroundColor: AppTheme.darkGreyContainer, child: Text('1', style: TextStyle(color: AppTheme.purpleColor, fontWeight: FontWeight.w700))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Método principal', style: TextStyle(color: AppTheme.whiteContainer, fontWeight: FontWeight.w700, fontSize: 16)), SizedBox(height: 6), Text('Elige cómo quieres recibir el código (SMS o Email).', style: TextStyle(color: AppTheme.lightGreyContainer, fontSize: 13))])),
              ]),
              const SizedBox(height: 12),
              MethodChoiceWidget(isSms: _method == MethodType.sms, onChanged: (isSms) => setState(() => _method = isSms ? MethodType.sms : MethodType.email)),
            ])),

            const SizedBox(height: 12),

            // Contacto + enviar
            ContactInputCard(controller: _contactController, enabled: _canEdit, onSend: _sendCode, isSms: _method == MethodType.sms),

            const SizedBox(height: 12),

            // Paso 2
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.inputBackgroundDark, borderRadius: AppTheme.border), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const Text('Verificar código', style: TextStyle(color: AppTheme.whiteContainer, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Ingresa el código que te enviamos para activar la verificación.', style: TextStyle(color: AppTheme.lightGreyContainer)),
              const SizedBox(height: 12),
              if (_sent && !_verified) VerificationCodeCard(enabled: _canEdit, onComplete: (c) => _onCompleteCode(c), onResend: _sendCode, secondsLeft: _secondsLeft, autoFocus: true),
              if (_verified) const SizedBox(height: 8),
                  if (_verified) const Text('Verificado', style: TextStyle(color: AppTheme.purpleColor, fontWeight: FontWeight.w700)),
            ])),
              // espacio dinámico para evitar overflow cuando aparece el teclado
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ]),
          ),
        ),
      ),
    );
  }
}