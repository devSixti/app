// Este archivo contiene el widget FareInput (input de tarifa)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/app_theme.dart';

class FareInput extends StatefulWidget {
  final Color? color;
  final ValueChanged<String>? onChanged;
  // Nuevo: permite hacer el campo de solo lectura para abrir un BottomSheet al tocarlo
  final bool readOnly;
  // Nuevo: texto inicial para mostrar cuando se usa en modo solo lectura
  final String? initialText;
  // Nuevo: callback al tocar el campo cuando readOnly=true
  final VoidCallback? onTap;

  const FareInput({super.key, this.color, this.onChanged, this.readOnly = false, this.initialText, this.onTap});

  @override
  State<FareInput> createState() => _FareInputState();
}

class _FareInputState extends State<FareInput> {
  late final TextEditingController _controller;
  // Usamos NumberFormat para agrupar miles; luego reemplazamos coma por punto
  final NumberFormat _formatter = NumberFormat('#,###', 'es_CO');
  bool _isApplyingFormat = false;
  
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
          return i + 1; // caret después del dígito target
        }
      }
    }
    return formatted.length;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onControllerChanged);
    // Nuevo: si viene un valor inicial (por ejemplo, cuando se selecciona desde un BottomSheet), lo aplicamos
    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      _controller.text = widget.initialText!;
    }
  }

  @override
  void didUpdateWidget(covariant FareInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Cuando el widget se usa como disparador (readOnly) y cambia el valor inicial, sincronizamos el texto
    if (widget.readOnly && widget.initialText != oldWidget.initialText) {
      final newText = widget.initialText ?? '';
      if (_controller.text != newText) {
        _controller.text = newText;
      }
    }
  }

  void _onControllerChanged() {
    if (_isApplyingFormat) return;

    final newValue = _controller.value;
    final raw = newValue.text;
    // quitamos todo lo que no sea dígito
    final digitsOnly = raw.replaceAll(RegExp(r'[^0-9]'), '');

    // Límite máximo permitido (1 millón)
    int intValue = int.tryParse(digitsOnly) ?? 0;
    const int maxValue = 1000000;
    if (intValue > maxValue) intValue = maxValue;

    final clampedDigits = intValue == 0 ? '' : intValue.toString();

    // Formateo con separador de miles (punto en es_CO)
    String formatted = clampedDigits.isEmpty
        ? ''
        : _formatter.format(intValue).replaceAll(',', '.');

    // Mantener posición del cursor
    final caret = newValue.selection.baseOffset.clamp(0, raw.length);
    final digitsBeforeCaret = _countDigitsBefore(raw, caret);
    final targetDigitIndex = digitsBeforeCaret.clamp(0, clampedDigits.length);
    final newCaretOffset = _offsetForDigitIndex(formatted, targetDigitIndex);

    _isApplyingFormat = true;
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCaretOffset),
    );
    _isApplyingFormat = false;

    // notificamos al padre con los dígitos sin formato (ej: "20000")
    widget.onChanged?.call(clampedDigits);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? Colors.white;

    return Material(
      color: Colors.transparent, // Esto evita que Material tire fondo blanco
      child: Container(
        // Contenedor del input
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color:  AppTheme.inputBackgroundDark, // Color de fondo del botón con opacidad
          borderRadius: AppTheme.border, // Bordes redondeados de todo el botón
          border: Border.all(
            color: AppTheme.darkBackground, // Color del borde del botón con opacidad
            width: 1, // Ancho del borde
          ),
        ),
        // Ajuste tamaño fijo del campo:
        // Se define una altura mínima fija para evitar que el campo cambie de tamaño al hacer foco.
        constraints: const BoxConstraints(
          minHeight: 40, // altura fija mínima (ajustable manualmente si se desea)
        ),
        child: Row(
          children: [
            Text(
              "COP",
              style: TextStyle(
                fontSize: AppTheme.mediumSize, // Tamaño de la fuente de "COP"
                fontWeight: FontWeight.bold, // Negrita
                color: AppTheme.lightBackground // Color del texto
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // Permitimos solo dígitos en la entrada (el formateo añade puntos programáticamente)
                  FilteringTextInputFormatter.digitsOnly,
                ],
                // Nuevo: permite usar el input en modo solo lectura para que actúe como disparador del BottomSheet
                readOnly: widget.readOnly,
                onTap: widget.onTap,
                style: const TextStyle(
                  fontSize: AppTheme.mediumSize, // más grande
                  fontWeight: FontWeight.w700, // más fuerte/negrita
                  color: AppTheme.inputBackgroundLight, // blanco brillante
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: "Ofrezca su tarifa",
                  // Ajuste opacidad del hint:
                  // Se incrementa ligeramente la opacidad para que se vea más visible sin perder el tono suave.
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.75), // antes era white54 (0.54), ahora un poco más visible
                    fontSize: AppTheme.mediumSize,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero, // elimina variaciones de altura del focus
                ),
                // onChanged no necesario porque usamos el listener del controller
              ),
            ),
            Icon(
              // Icono de moneda de la tarifa ($)
              Icons.attach_money,
              color: effectiveColor, // Color del icono
              size: 28, // Tamaño del icono
            ),
          ],
        ),
      ),
    );
  }
}
