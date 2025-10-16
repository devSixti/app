import 'dart:async';
import 'dart:math';

import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'verification_step_widget.dart';

enum MethodType { sms, email }

// Formatea y limita números telefónicos con prefijo opcional '+' y máximo 10 dígitos
class PhoneWithPrefixFormatter extends TextInputFormatter {
  final int maxDigits;
  PhoneWithPrefixFormatter({this.maxDigits = 10});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final hasPlus = text.startsWith('+');
    // Extraer sólo dígitos
    final digits = text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length <= maxDigits
        ? digits
        : digits.substring(0, maxDigits);

    final resultText = hasPlus ? '+$limited' : limited;

    // Mantener el cursor al final
    return TextEditingValue(
      text: resultText,
      selection: TextSelection.collapsed(offset: resultText.length),
    );
  }
}

class TwoStepVerificationScreen extends StatefulWidget {
  const TwoStepVerificationScreen({super.key});

  @override
  State<TwoStepVerificationScreen> createState() =>
      _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
  MethodType _method = MethodType.sms;
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _sent = false;
  bool _verified = false;
  bool _canEdit = false;
  String? _sentCode;
  Timer? _timer;
  int _secondsLeft = 0;

  @override
  void dispose() {
    _contactController.dispose();
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer([int seconds = 120]) {
    _timer?.cancel();
    setState(() {
      _secondsLeft = seconds;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() {
          _secondsLeft = 0;
          _sent = false; // allow resend
        });
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  String _generateCode() {
    final rnd = Random();
    final code = List.generate(6, (_) => rnd.nextInt(10)).join();
    return code;
  }

  void _sendCode() {
    if (!_canEdit) return;
    final contact = _contactController.text.trim();
    if (contact.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa número de teléfono o email.')),
      );
      return;
    }

    _sentCode = _generateCode();
    _sent = true;
    _verified = false;
    _codeController.clear();
    _startTimer(120);

    // Envío simulado eliminado: no mostramos el código en la UI
  }

  void _verifyCode() {
    if (!_canEdit) return;
    if (_codeController.text.trim() == _sentCode) {
      setState(() {
        _verified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código verificado correctamente.')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Código incorrecto.')));
    }
  }

  void _toggleMethod(MethodType m) {
    setState(() {
      _method = m;
      _contactController.clear();
      _sent = false;
      _codeController.clear();
      _sentCode = null;
      _timer?.cancel();
      _secondsLeft = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkDrawerBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkGreyContainer,
        elevation: 0,
        title: const Text(
          'Verificación en Dos Pasos',
          style: TextStyle(color: AppTheme.whiteContainer),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppTheme.whiteContainer,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Interruptor superior para alternar edición (ubicado al inicio) + indicador (texto a la derecha)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            _codeController.clear();
                            _sentCode = null;
                            _timer?.cancel();
                            _secondsLeft = 0;
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _canEdit ? 'Editar' : 'Bloqueado',
                      style: TextStyle(
                        color: _canEdit ? AppTheme.primaryColor : AppTheme.lightGreyContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Resto de la vista — se envuelve para bloquear interacción cuando no está habilitado
                AbsorbPointer(
                  absorbing: !_canEdit,
                  child: Opacity(
                    opacity: _canEdit ? 1.0 : 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Caja personalizada para el paso 1: texto arriba, botones abajo
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.inputBackgroundDark,
                            borderRadius: AppTheme.border,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: AppTheme.darkGreyContainer,
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                          color: AppTheme.purpleColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Método principal',
                                          style: TextStyle(
                                            color: AppTheme.whiteContainer,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          'Elige cómo quieres recibir el código (SMS o Email).',
                                          style: TextStyle(
                                            color: AppTheme.lightGreyContainer,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 8,
                                  children: [
                                    ChoiceChip(
                                      label: const Text('SMS'),
                                      selected: _method == MethodType.sms,
                                      onSelected: (_) => _toggleMethod(MethodType.sms),
                                      selectedColor: AppTheme.purpleColor,
                                      backgroundColor: AppTheme.darkGreyContainer,
                                      labelStyle: TextStyle(
                                        color: _method == MethodType.sms
                                            ? AppTheme.whiteContainer
                                            : AppTheme.silver,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ChoiceChip(
                                      label: const Text('Email'),
                                      selected: _method == MethodType.email,
                                      onSelected: (_) => _toggleMethod(MethodType.email),
                                      selectedColor: AppTheme.purpleColor,
                                      backgroundColor: AppTheme.darkGreyContainer,
                                      labelStyle: TextStyle(
                                        color: _method == MethodType.email
                                            ? AppTheme.whiteContainer
                                            : AppTheme.silver,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Input para número o email
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.inputBackgroundDark,
                            borderRadius: AppTheme.border,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _method == MethodType.sms
                                    ? 'Número de teléfono'
                                    : 'Correo electrónico',
                                style: const TextStyle(
                                  color: AppTheme.whiteContainer,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                enabled: _canEdit,
                                controller: _contactController,
                                keyboardType: _method == MethodType.sms
                                    ? TextInputType.phone
                                    : TextInputType.emailAddress,
                                inputFormatters: _method == MethodType.sms
                                    ? <TextInputFormatter>[
                                        PhoneWithPrefixFormatter(maxDigits: 10),
                                      ]
                                    : null,
                                decoration: InputDecoration(
                                  hintText: _method == MethodType.sms
                                      ? '+57 300 000 0000'
                                      : 'tu@correo.com',
                                  hintStyle: const TextStyle(
                                    color: AppTheme.lightGreyContainer,
                                  ),
                                  filled: true,
                                  fillColor: AppTheme.darkGreyContainer,
                                  border: OutlineInputBorder(
                                    borderRadius: AppTheme.border,
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _sent ? null : _sendCode,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.primaryColor,
                                        foregroundColor: AppTheme.blackContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: AppTheme.border,
                                        ),
                                      ),
                                      child: Text(
                                        _sent
                                            ? 'Enviado (${_secondsLeft}s)'
                                            : 'Enviar Código',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        VerificationStepWidget(
                          stepNumber: 2,
                          title: 'Verificar código',
                          description:
                              'Ingresa el código que te enviamos para activar la verificación.',
                          trailing: _verified
                              ? const Text(
                                  'Verificado',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : null,
                          onTap: () {},
                        ),

                        const SizedBox(height: 12),

                        if (_sent && !_verified) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.inputBackgroundDark,
                              borderRadius: AppTheme.border,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextField(
                                  enabled: _canEdit,
                                  controller: _codeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Código de 6 dígitos',
                                    border: InputBorder.none,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: _verifyCode,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.primaryColor,
                                          foregroundColor: AppTheme.blackContainer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: AppTheme.border,
                                          ),
                                        ),
                                        child: const Text('Verificar'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      onPressed: _secondsLeft == 0 ? _sendCode : null,
                                      child: Text(
                                        _secondsLeft == 0
                                            ? 'Reenviar'
                                            : 'Reenviar ($_secondsLeft)',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
