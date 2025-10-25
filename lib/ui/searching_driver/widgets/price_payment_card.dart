// Tarjeta que muestra el precio y método de pago

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'price_section.dart';
import 'payment_section.dart';

class PricePaymentCard extends StatelessWidget {
  final double currentPrice;
  final String paymentMethod;
  final Function(double) onIncrementPrice;

  const PricePaymentCard({
    super.key,
    required this.currentPrice,
    required this.paymentMethod,
    required this.onIncrementPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: AppTheme.border,
      ),
      child: Row(
        children: [
          // Sección de precio (izquierda)
          Expanded(
            child: PriceSection(
              currentPrice: currentPrice,
              onIncrementPrice: onIncrementPrice,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Línea divisoria vertical
          Container(
            width: 1,
            height: 80,
            color: AppTheme.silver.withOpacity(0.3),
          ),
          
          const SizedBox(width: 16),
          
          // Sección de pago (derecha)
          Expanded(
            child: PaymentSection(paymentMethod: paymentMethod),
          ),
        ],
      ),
    );
  }
}
