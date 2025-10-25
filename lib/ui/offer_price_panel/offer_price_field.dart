// Widget: OfferPriceField
// Dispara el panel OfferPriceBottomSheet manteniendo el estilo visual del campo existente (FareInput)

import 'package:flutter/material.dart';
import 'package:app/ui/form_trips/widgets/fare_input.dart';
import 'package:app/ui/offer_price_panel/offer_price_bottom_sheet.dart';

class OfferPriceField extends StatefulWidget {
  final ValueChanged<double?>? onChanged;
  final ValueChanged<String>? onPaymentMethodChanged;
  final String? initialValue;
  final String initialMethod; // "Efectivo" por defecto
  final bool initialAutoAccept;

  const OfferPriceField({
    super.key,
    this.onChanged,
    this.onPaymentMethodChanged,
    this.initialValue,
    this.initialMethod = 'Efectivo',
    this.initialAutoAccept = false,
  });

  @override
  State<OfferPriceField> createState() => _OfferPriceFieldState();
}

class _OfferPriceFieldState extends State<OfferPriceField> {
  String? _valueDigits; // solo dígitos sin formato
  String _method = 'Efectivo';
  bool _autoAccept = false;

  @override
  void initState() {
    super.initState();
    _valueDigits = widget.initialValue;
    _method = widget.initialMethod;
    _autoAccept = widget.initialAutoAccept;
  }

  Future<void> _openSheet() async {
    final result = await showModalBottomSheet<OfferPriceResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OfferPriceBottomSheet(
        initialValue: _valueDigits,
        initialMethod: _method,
        initialAutoAccept: _autoAccept,
      ),
    );

    if (result != null) {
      setState(() {
        _valueDigits = result.digits;
        _method = result.method;
        _autoAccept = result.autoAccept;
      });
      widget.onChanged?.call(double.tryParse(result.digits));
      widget.onPaymentMethodChanged?.call(result.method);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reutilizamos FareInput con readOnly para mantener el diseño original
    return FareInput(
      readOnly: true,
      initialText: _valueDigits, // se mostrará formateado por FareInput
      onTap: _openSheet,
      onChanged: (_) {}, // sin uso en modo readOnly
    );
  }
}
