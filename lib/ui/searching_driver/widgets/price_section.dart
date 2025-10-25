// Sección del precio con botones de incremento

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class PriceSection extends StatelessWidget {
  final double currentPrice;
  final Function(double) onIncrementPrice;

  const PriceSection({
    super.key,
    required this.currentPrice,
    required this.onIncrementPrice,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: 'COP ',
      decimalDigits: 0,
    );

    return Container(
      width: double.infinity, // Ocupa todo el ancho disponible
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
      children: [
        // Etiqueta "Tu precio"
        const Text(
          'Tu precio',
          style: TextStyle(
            fontSize: AppTheme.smallSize,
            color: AppTheme.silver,
          ),
        ),
        
        const SizedBox(height: 4),
        
        // Precio actual
        Text(
          formatter.format(currentPrice),
          style: const TextStyle(
            fontSize: AppTheme.smallSize,
            fontWeight: FontWeight.bold,
            color: AppTheme.whiteContainer,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Botones de incremento
        Row(
          children: [
            _IncrementButton(
              label: '+500',
              color: AppTheme.purpleColor,
              onPressed: () => onIncrementPrice(500),
            ),
            const SizedBox(width: 8),
            _IncrementButton(
              label: '+1000',
              color: AppTheme.primaryColor,
              onPressed: () => onIncrementPrice(1000),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Tarifa sugerida
        const Text(
          'Tarifa sugerida: ',
          style: TextStyle(
            fontSize: AppTheme.smallSize,
            color: AppTheme.silver,
          ),
        ),
        ],
      ),
    );
  }
}

class _IncrementButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _IncrementButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppTheme.whiteContainer,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: AppTheme.smallSize + 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
