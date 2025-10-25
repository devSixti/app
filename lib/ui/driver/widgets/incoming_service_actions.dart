import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class IncomingServiceActions extends StatelessWidget {
  const IncomingServiceActions({
    required this.remainingSeconds,
    required this.totalSeconds,
    required this.paymentMethod,
    required this.onAccept,
    required this.onDecline,
    super.key,
  });

  final int remainingSeconds;
  final int totalSeconds;
  final String paymentMethod;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text('Método de pago: $paymentMethod', style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: (totalSeconds > 0) ? (remainingSeconds / totalSeconds) : 0,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.purpleColor),
                  minHeight: 6,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 48,
              child: Text('${remainingSeconds}s', style: const TextStyle(color: AppTheme.purpleColor, fontSize: 12), textAlign: TextAlign.right),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onAccept,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                child: const Text('Aceptar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: onDecline,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.purpleColor),
                child: const Text('Rechazar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
