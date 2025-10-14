// Este archivo contiene el widget FareInput (input de tarifa)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/app_theme.dart';

class FareInput extends StatefulWidget {
  final Color? color;
  final ValueChanged<String>? onChanged;

  const FareInput({super.key, this.color, this.onChanged});

  @override
  State<FareInput> createState() => _FareInputState();
}

class _FareInputState extends State<FareInput> {
  late final TextEditingController _controller;
  // Usamos NumberFormat para agrupar miles; luego reemplazamos coma por punto
  final NumberFormat _formatter = NumberFormat('#,###');
  bool _isApplyingFormat = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (_isApplyingFormat) return;

    final original = _controller.text;
    // quitamos todo lo que no sea dígito
    final digitsOnly = original.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      _isApplyingFormat = true;
      _controller.value = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      _isApplyingFormat = false;
      widget.onChanged?.call('');
      return;
    }

    // parse seguro
    int intValue = int.tryParse(digitsOnly) ?? 0;

    // *** Límite máximo permitido (1 millón) ***
    // Si el valor supera el millón, lo limitamos
    const int maxValue = 1000000;
    if (intValue > maxValue) {
      intValue = maxValue;
    }

    // formateamos con separador (NumberFormat devuelve con coma por defecto en muchos locales)
    String formatted = _formatter.format(intValue);
    // sustituimos coma por punto para obtener 20.000 (si el formatter usa coma)
    formatted = formatted.replaceAll(',', '.');

    // si el texto ya estaba formateado, solo notificamos; si no, aplicamos el formateo
    if (formatted != original) {
      _isApplyingFormat = true;
      _controller.value = TextEditingValue(
        text: formatted,
        // dejamos el cursor al final (esto es simple y evita cálculos complejos)
        selection: TextSelection.collapsed(offset: formatted.length),
      );
      _isApplyingFormat = false;
    }

    // notificamos al padre con los dígitos sin formato (ej: "20000")
    widget.onChanged?.call(digitsOnly);
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
