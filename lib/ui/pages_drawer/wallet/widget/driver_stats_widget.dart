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
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.purpleColor.withOpacity(0.1),
            AppTheme.blackContainer.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.4, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
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
                      AppTheme.purpleColor.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: AppTheme.whiteContainer,
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
                  AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Esta Semana',
                  weeklyEarnings,
                  Icons.date_range_rounded,
                  AppTheme.purpleColor,
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
                  AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Viajes Totales',
                  totalTrips.toDouble(),
                  Icons.directions_car_rounded,
                  AppTheme.purpleColor,
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
        color: AppTheme.blackContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
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