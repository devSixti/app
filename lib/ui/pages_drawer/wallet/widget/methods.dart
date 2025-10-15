import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PaymentMethodsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final Function(Map<String, dynamic>) onMethodTap;
  final VoidCallback onAddMethod;

  const PaymentMethodsWidget({
    super.key,
    required this.paymentMethods,
    required this.onMethodTap,
    required this.onAddMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.inputBackgroundDark,
            AppTheme.darkGreyContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppTheme.border,
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.blackContainer.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.2),
                      AppTheme.primaryColor.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(
                  Icons.credit_card_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Métodos de Pago',
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: AppTheme.border,
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: AppTheme.border,
                    onTap: onAddMethod,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.add_rounded,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          if (paymentMethods.isEmpty)
            _buildEmptyState()
          else
            ...paymentMethods.map((method) => _buildPaymentMethodItem(method)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    final isDefault = method['isDefault'] as bool? ?? false;
    final type = method['type'] as String;
    final color = _getCardColor(type);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.blackContainer.withOpacity(0.2),
        borderRadius: AppTheme.border,
        border: Border.all(
          color: isDefault 
            ? AppTheme.primaryColor.withOpacity(0.5)
            : color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTheme.border,
          onTap: () => onMethodTap(method),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: AppTheme.border,
                  ),
                  child: Icon(_getCardIcon(type), color: color, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _getCardName(type),
                            style: const TextStyle(
                              color: AppTheme.whiteContainer,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (isDefault) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8, 
                                vertical: 4
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.2),
                                borderRadius: AppTheme.border
                              ),
                              child: const Text(
                                'Principal',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        method['number'] as String,
                        style: const TextStyle(
                          color: AppTheme.lightGreyContainer,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color.withOpacity(0.6),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
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
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: AppTheme.border,
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.credit_card_off_rounded,
              color: AppTheme.primaryColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No tienes métodos de pago',
            style: TextStyle(
              color: AppTheme.whiteContainer,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Agrega una tarjeta o cuenta bancaria para realizar pagos',
            style: TextStyle(
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

  Color _getCardColor(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
        return const Color(0xFF1A1F71);
      case 'mastercard':
        return const Color(0xFFEB001B);
      case 'bank':
        return AppTheme.purpleColor;
      case 'digital':
        return AppTheme.primaryColor;
      default:
        return AppTheme.lightGreyContainer;
    }
  }

  IconData _getCardIcon(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
      case 'mastercard':
        return Icons.credit_card_rounded;
      case 'bank':
        return Icons.account_balance_rounded;
      case 'digital':
        return Icons.smartphone_rounded;
      default:
        return Icons.payment_rounded;
    }
  }

  String _getCardName(String type) {
    switch (type.toLowerCase()) {
      case 'visa':
        return 'Visa';
      case 'mastercard':
        return 'Mastercard';
      case 'bank':
        return 'Cuenta Bancaria';
      case 'digital':
        return 'Billetera Digital';
      default:
        return 'Método de Pago';
    }
  }
}