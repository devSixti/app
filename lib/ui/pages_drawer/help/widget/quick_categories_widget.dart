import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class QuickCategoriesWidget extends StatelessWidget {
  final Function(String) onCategorySelected;

  const QuickCategoriesWidget({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categorías Populares',
            style: TextStyle(
              color: AppTheme.whiteContainer,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildCategoryChip(
                  'Pagos',
                  Icons.payment_rounded,
                  iconColor: AppTheme.primaryColor,
                  textColor: AppTheme.silver,
                ),
                _buildCategoryChip(
                  'Viajes',
                  Icons.directions_car_rounded,
                  iconColor: AppTheme.primaryColor,
                  textColor: AppTheme.silver,
                ),
                _buildCategoryChip(
                  'Cuenta',
                  Icons.account_circle_rounded,
                  iconColor: AppTheme.primaryColor,
                  textColor: AppTheme.silver,
                ),
                _buildCategoryChip(
                  'Seguridad',
                  Icons.security_rounded,
                  iconColor: AppTheme.primaryColor,
                  textColor: AppTheme.silver,
                ),
                _buildCategoryChip(
                  'Soporte',
                  Icons.support_agent_rounded,
                  iconColor: AppTheme.primaryColor,
                  textColor: AppTheme.silver,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    IconData icon, {
    required Color iconColor,
    required Color textColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkGreyContainer,
        borderRadius: AppTheme.border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTheme.border,
          onTap: () => onCategorySelected(label),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 18),
                const SizedBox(width: 2),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
