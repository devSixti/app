import 'package:app/ui/pages_drawer/travels_history/widget/item.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TravelsListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> trips;
  final Function(Map<String, dynamic>) onTripTap;

  const TravelsListWidget({
    super.key,
    required this.trips,
    required this.onTripTap,
  });

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tus Viajes (${trips.length})',
          style: const TextStyle(
            color: AppTheme.whiteContainer,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        ...trips.map((trip) {
          return TravelItemWidget(
            trip: trip,
            onTap: () => onTripTap(trip),
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.2),
                  AppTheme.purpleColor.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.inputBackgroundDark,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.history_rounded,
                color: AppTheme.primaryColor,
                size: 48,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No hay viajes encontrados',
            style: TextStyle(
              color: AppTheme.whiteContainer,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Cuando realices tu primer viaje, aparecerá aquí en tu historial',
            style: TextStyle(
              color: AppTheme.lightGreyContainer,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
  decoration: BoxDecoration(
    color: AppTheme.primaryColor.withOpacity(0.8),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppTheme.primaryColor.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  // Navegar a solicitar viaje
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: AppTheme.whiteContainer,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Solicitar mi primer viaje',
                        style: TextStyle(
                          color: AppTheme.whiteContainer,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}