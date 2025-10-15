import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TravelsStatsWidget extends StatelessWidget {
  final int totalTrips;
  final double totalSpent;
  final int thisMonth;

  const TravelsStatsWidget({
    super.key,
    required this.totalTrips,
    required this.totalSpent,
    required this.thisMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total de Viajes',
              totalTrips.toString(),
              Icons.directions_car_rounded,
              AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Gastado Total',
              '\$${totalSpent.toStringAsFixed(0)}K',
              Icons.attach_money_rounded,
              AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
                'Este Mes\n',
              thisMonth.toString(),
              Icons.calendar_today_rounded,
              AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
        borderRadius: AppTheme.border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: AppTheme.border,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.lightGreyContainer,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}