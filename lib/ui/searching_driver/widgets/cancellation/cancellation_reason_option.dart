// Widget para cada opción de cancelación

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'cancellation_reason.dart';

class CancellationReasonOption extends StatelessWidget {
  final CancellationReason reason;
  final VoidCallback onTap;

  const CancellationReasonOption({
    super.key,
    required this.reason,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Icono
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.purpleColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                reason.icon,
                color: AppTheme.purpleColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reason.title,
                    style: TextStyle(
                      fontSize: AppTheme.mediumSize - 2,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reason.description,
                    style: TextStyle(
                      fontSize: AppTheme.smallSize + 2,
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.6)
                          : Colors.black54,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Flecha
            Icon(
              Icons.chevron_right,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.4)
                  : Colors.black38,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
