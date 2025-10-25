// Panel inferior: OfferPriceBottomSheet
// Contiene: título, input grande con prefijo "COP", método de pago, switch de auto-aceptar, botón "Listo" y un keypad numérico integrado

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/ui/offer_price_panel/payment_method_sheet.dart';

class OfferPriceResult {
  final String digits; // valor sin formato, solo dígitos
  final String method; // texto del método de pago
  final bool autoAccept;
  OfferPriceResult({required this.digits, required this.method, required this.autoAccept});
}

class OfferPriceBottomSheet extends StatefulWidget {
  final String? initialValue; // dígitos
  final String initialMethod;
  final bool initialAutoAccept;

  const OfferPriceBottomSheet({
    super.key,
    this.initialValue,
    this.initialMethod = 'Efectivo',
    this.initialAutoAccept = false,
  });

  @override
  State<OfferPriceBottomSheet> createState() => _OfferPriceBottomSheetState();
}

class _OfferPriceBottomSheetState extends State<OfferPriceBottomSheet> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final NumberFormat _formatter = NumberFormat('#,###');
  bool _isApplyingFormat = false;

  String _digits = '';
  String _method = 'Efectivo';
  bool _autoAccept = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _controller.text.isNotEmpty) {
        _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      }
    });
    _controller.addListener(_onControllerChanged);
    _digits = widget.initialValue ?? '';
    _method = widget.initialMethod;
    _autoAccept = widget.initialAutoAccept;
    if (_digits.isNotEmpty) {
      // Aseguramos límite inicial y mostramos formateado dentro del sheet
      int intValue = int.tryParse(_digits.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      const int maxValue = 1000000;
      if (intValue > maxValue) intValue = maxValue;
      _digits = intValue == 0 ? '' : intValue.toString();
      _applyFormattedFromDigits();
    } else {
      _isApplyingFormat = true;
      _controller.value = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      _isApplyingFormat = false;
    }
  }
 
  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (_isApplyingFormat) return;
    final newValue = _controller.value;
    final raw = newValue.text;
    final digitsOnly = raw.replaceAll(RegExp(r'[^0-9]'), '');
    // Límite máximo 1.000.000
    int intValue = int.tryParse(digitsOnly) ?? 0;
    const int maxValue = 1000000;
    if (intValue > maxValue) intValue = maxValue;
    final clampedDigits = intValue == 0 ? '' : intValue.toString();

    // Formateo con puntos de miles
    final formatted = _group(clampedDigits);

    // Mantener posición del cursor: contamos dígitos antes del cursor actual
    final currentCaret = newValue.selection.baseOffset.clamp(0, raw.length);
    final digitsBeforeCaret = _countDigitsBefore(raw, currentCaret);
    final targetDigitIndex = digitsBeforeCaret.clamp(0, clampedDigits.length);
    final newCaretOffset = _offsetForDigitIndex(formatted, targetDigitIndex);

    _isApplyingFormat = true;
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCaretOffset),
    );
    _isApplyingFormat = false;

    _digits = clampedDigits;
  }

  int _countDigitsBefore(String text, int offset) {
    int count = 0;
    final end = offset.clamp(0, text.length);
    for (int i = 0; i < end; i++) {
      final ch = text.codeUnitAt(i);
      if (ch >= 48 && ch <= 57) count++;
    }
    return count;
  }

  int _offsetForDigitIndex(String formatted, int digitIndex) {
    if (digitIndex <= 0) return 0;
    int seen = 0;
    for (int i = 0; i < formatted.length; i++) {
      final ch = formatted.codeUnitAt(i);
      if (ch >= 48 && ch <= 57) {
        seen++;
        if (seen == digitIndex) {
          // caret después de este dígito
          return i + 1;
        }
      }
    }
    // si hay menos dígitos, ir al final
    return formatted.length;
  }

  String _group(String digits) {
    if (digits.isEmpty) return '';
    int value = int.tryParse(digits) ?? 0;
    const int maxValue = 1000000;
    if (value > maxValue) value = maxValue;
    String formatted = _formatter.format(value).replaceAll(',', '.');
    return formatted;
  }

  void _applyFormattedFromDigits() {
    final formatted = _group(_digits);
    _isApplyingFormat = true;
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    _isApplyingFormat = false;
  }

  // Eliminado keypad personalizado: ahora solo se usa el teclado del sistema.

  String _getPaymentIcon(String method) {
    final methodLower = method.toLowerCase();
    if (methodLower.contains('nequi')) {
      return 'assets/images/metodos_pago/nequi.webp';
    } else if (methodLower.contains('daviplata')) {
      return 'assets/images/metodos_pago/daviplata.png';
    } else if (methodLower.contains('bancolombia')) {
      return 'assets/images/metodos_pago/bancolombia.png';
    } else {
      return 'assets/images/dollars.png';
    }
  }

  Future<void> _openPaymentSheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (_) => PaymentMethodSheet(selected: _method),
    );
    if (selected != null) {
      setState(() {
        _method = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkGreyContainer,
          borderRadius: BorderRadius.only(
            topLeft: radius.topLeft,
            topRight: radius.topRight,
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Ofrezca su tarifa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppTheme.largeSize,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightBackground,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: AppTheme.lightBackground),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.inputBackgroundDark,
                    borderRadius: AppTheme.border,
                    border: Border.all(color: AppTheme.darkBackground, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'COP',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightBackground,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.inputBackgroundLight,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: '',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.75),
                              fontSize: 28,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: _openPaymentSheet,
                  borderRadius: AppTheme.border,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          _getPaymentIcon(_method),
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.attach_money,
                              color: AppTheme.primaryColor,
                              size: 20,
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _method,
                            style: const TextStyle(
                              color: AppTheme.lightBackground,
                              fontSize: AppTheme.mediumSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppTheme.lightBackground),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.auto_mode, color: AppTheme.lightBackground),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Aceptar automáticamente al conductor más cercano por tu precio',
                        style: TextStyle(
                          color: AppTheme.lightBackground,
                          fontSize: AppTheme.smallSize,
                        ),
                      ),
                    ),
                    Switch(
                      value: _autoAccept,
                      onChanged: (v) => setState(() => _autoAccept = v),
                      activeColor: AppTheme.purpleColor,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        OfferPriceResult(digits: _digits, method: _method, autoAccept: _autoAccept),
                      );
                    },
                    label: const Text('Listo', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
