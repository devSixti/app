// Panel inferior secundario: PaymentMethodSheet
// Lista de métodos de pago con ícono + texto. Devuelve el seleccionado como String.

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class PaymentMethodSheet extends StatelessWidget {
  final String selected;
  const PaymentMethodSheet({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    final methods = <_MethodItem>[
      _MethodItem('Efectivo', Icons.attach_money),
      _MethodItem('nequi', Icons.check_box),
      _MethodItem('daviplata', Icons.account_balance_wallet),
      _MethodItem('bancolombia', Icons.account_balance),
    ];

    Widget item(_MethodItem m) {
      final isSel = m.label.toLowerCase() == selected.toLowerCase();
      return InkWell(
        onTap: () => Navigator.pop(context, m.label),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(m.icon, color: AppTheme.primaryColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  m.label,
                  style: const TextStyle(
                    color: AppTheme.lightBackground,
                    fontSize: AppTheme.mediumSize,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: isSel ? AppTheme.primaryColor : AppTheme.lightBackground),
            ],
          ),
        ),
      );
    }

    return Container(
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
                      'Selecciona un método de pago',
                      style: TextStyle(
                        fontSize: AppTheme.mediumSize,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightBackground,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: AppTheme.lightBackground),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              for (final m in methods) item(m),
            ],
          ),
        ),
      ),
    );
  }
}

class _MethodItem {
  final String label;
  final IconData icon;
  const _MethodItem(this.label, this.icon);
}
