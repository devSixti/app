// Sección del método de pago

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class PaymentSection extends StatelessWidget {
  final String paymentMethod;

  const PaymentSection({
    super.key,
    required this.paymentMethod,
  });

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Etiqueta "Pago:"
        const Text(
          'Pago:',
          style: TextStyle(
            fontSize: AppTheme.smallSize,
            color: AppTheme.silver,
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Ícono y método de pago
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getPaymentIcon(paymentMethod),
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
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                paymentMethod,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: AppTheme.smallSize + 2,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.whiteContainer,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
