import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PayMethodBadge extends StatelessWidget {
  const PayMethodBadge({required this.method, super.key});

  final String method;

  @override
  Widget build(BuildContext context) {
    final m = method.toLowerCase();
    IconData icon;
    String label;
    Color bg = AppTheme.inputBackgroundDark;

    switch (m) {
      case 'nequi':
        icon = Icons.account_balance_wallet;
        label = 'Nequi';
        bg = AppTheme.primaryColor;
        break;
      case 'tarjeta':
      case 'card':
      case 'credit':
        icon = Icons.credit_card;
        label = 'Tarjeta';
        bg = AppTheme.primaryColor;
        break;
      case 'efectivo':
      case 'cash':
      default:
        icon = Icons.money;
        label = 'Efectivo';
        bg = AppTheme.primaryColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 14, color: Colors.black87), const SizedBox(width: 6), Text(label, style: const TextStyle(color: Colors.black87, fontSize: 12))]),
    );
  }
}
