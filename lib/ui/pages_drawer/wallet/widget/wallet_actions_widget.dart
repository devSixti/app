import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class WalletActionsWidget extends StatelessWidget {
  final bool isDriver;
  final VoidCallback onAddMoney;
  final VoidCallback onWithdraw;
  final VoidCallback onTransfer;
  final VoidCallback onPayments;

  const WalletActionsWidget({
    super.key,
    this.isDriver = false,
    required this.onAddMoney,
    required this.onWithdraw,
    required this.onTransfer,
    required this.onPayments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              'Agregar\nDinero',
              Icons.add_card_rounded,
              onAddMoney,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              'Retirar\nDinero',
              Icons.money_rounded,
              onWithdraw,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              'Pagos\n',
              isDriver ? Icons.trending_up_rounded : Icons.payment_rounded,
              onPayments,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: AppTheme.border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTheme.border,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.silver.withOpacity(0.3),
                    borderRadius: AppTheme.border,
                  ),
                  child: Icon(icon, color: AppTheme.silver, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.silver,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}