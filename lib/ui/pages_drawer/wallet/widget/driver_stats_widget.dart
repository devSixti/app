import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class DriverStatsWidget extends StatelessWidget {
  final double dailyEarnings;
  final double weeklyEarnings;
  final double monthlyEarnings;
  final int totalTrips;

  const DriverStatsWidget({
    super.key,
    required this.dailyEarnings,
    required this.weeklyEarnings,
    required this.monthlyEarnings,
    required this.totalTrips,
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
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: AppTheme.border,
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Estadísticas de Ganancias',
                  style: TextStyle(
                    color: AppTheme.whiteContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Ganancias por período
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Hoy',
                  dailyEarnings,
                  Icons.today_rounded,
                  AppTheme.silver,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Esta Semana',
                  weeklyEarnings,
                  Icons.date_range_rounded,
                  AppTheme.silver,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Este Mes',
                  monthlyEarnings,
                  Icons.calendar_month_rounded,
                  AppTheme.silver,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Viajes Totales',
                  totalTrips.toDouble(),
                  Icons.directions_car_rounded,
                  AppTheme.silver,
                  isCount: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, double value, IconData icon, Color color, {bool isCount = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkDrawerBackground,
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
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            isCount ? value.toInt().toString() : '\$${value.toStringAsFixed(0)}',
            style: TextStyle(
              color: color,
              fontSize: 18,
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