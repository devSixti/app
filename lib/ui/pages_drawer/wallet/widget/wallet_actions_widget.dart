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
              AppTheme.primaryColor,
              onAddMoney,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              isDriver ? 'Retirar' : 'Retirar\nDinero',
              Icons.money_rounded,
              AppTheme.purpleColor,
              onWithdraw,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              'Transferir',
              Icons.send_rounded,
              AppTheme.primaryColor,
              onTransfer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              isDriver ? 'Ganancias' : 'Pagos',
              isDriver ? Icons.trending_up_rounded : Icons.payment_rounded,
              AppTheme.purpleColor,
              onPayments,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            AppTheme.inputBackgroundDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.blackContainer.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
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