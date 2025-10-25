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
      _MethodItem('Efectivo', 'assets/images/dollars.png'),
      _MethodItem('nequi', 'assets/images/metodos_pago/nequi.webp'),
      _MethodItem('daviplata', 'assets/images/metodos_pago/daviplata.png'),
      _MethodItem('bancolombia', 'assets/images/metodos_pago/bancolombia.png'),
    ];

  Widget item(_MethodItem m) {
  final isSel = m.label.toLowerCase() == selected.toLowerCase();

  // Tamaño del ícono (más pequeño para efectivo)
  final double iconSize = m.label.toLowerCase().contains('efectivo') ? 18 : 22;

  return InkWell(
    onTap: () => Navigator.pop(context, m.label),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Imagen del método de pago
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              m.iconPath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.attach_money,
                  color: AppTheme.primaryColor,
                  size: iconSize,
                );
              },
            ),
          ),
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
          Icon(
            Icons.chevron_right,
            color: isSel ? AppTheme.primaryColor : AppTheme.lightBackground,
          ),
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
  final String iconPath;
  const _MethodItem(this.label, this.iconPath);
}
