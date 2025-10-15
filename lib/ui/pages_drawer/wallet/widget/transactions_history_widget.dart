import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TransactionsHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final bool isDriver;

  const TransactionsHistoryWidget({
    super.key,
    required this.transactions,
    this.isDriver = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppTheme.inputBackgroundDark,
        borderRadius: AppTheme.border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.purpleColor.withOpacity(0.1),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: AppTheme.purpleColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Transacciones Recientes',
                  style: const TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Ver todas las transacciones
                },
                child: const Text(
                  'Ver todas',
                  style: TextStyle(
                    color: AppTheme.purpleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          if (transactions.isEmpty)
            _buildEmptyState()
          else
            ...transactions.take(5).map((transaction) => 
              _buildTransactionItem(transaction)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final type = transaction['type'] as String;
    final amount = transaction['amount'] as double;
    final isPositive = amount > 0;
    final color = isPositive ? AppTheme.primaryColor : AppTheme.red;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.2),
        borderRadius: AppTheme.border,
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: AppTheme.border,
            ),
            child: Icon(
              _getTransactionIcon(type),
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['description'] as String,
                  style: const TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(transaction['status']).withOpacity(0.2),
                        borderRadius: AppTheme.border
                      ),
                      child: Text(
                        _getStatusText(transaction['status']),
                        style: TextStyle(
                          color: _getStatusColor(transaction['status']),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : ''}\$${amount.abs().toStringAsFixed(0)}',
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.purpleColor.withOpacity(0.1),
              borderRadius: AppTheme.border,
              border: Border.all(
                color: AppTheme.purpleColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: AppTheme.purpleColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isDriver ? 'No tienes ganancias aún' : 'No hay transacciones',
            style: const TextStyle(
              color: AppTheme.whiteContainer,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isDriver 
              ? 'Cuando completes viajes, tus ganancias aparecerán aquí'
              : 'Cuando realices pagos, aparecerán en tu historial',
            style: const TextStyle(
              color: AppTheme.lightGreyContainer,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'trip':
        return Icons.directions_car_rounded;
      case 'withdrawal':
        return Icons.money_rounded;
      case 'deposit':
        return Icons.add_card_rounded;
      case 'transfer':
        return Icons.send_rounded;
      case 'earning':
        return Icons.trending_up_rounded;
      default:
        return Icons.receipt_rounded;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppTheme.primaryColor;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return AppTheme.red;
      default:
        return AppTheme.lightGreyContainer;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completado';
      case 'pending':
        return 'Pendiente';
      case 'failed':
        return 'Fallido';
      default:
        return 'Desconocido';
    }
  }
}