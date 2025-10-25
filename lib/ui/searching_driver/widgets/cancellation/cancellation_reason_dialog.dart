// Diálogo para seleccionar el motivo de cancelación del viaje

import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'cancellation_reason.dart';

class CancellationReasonDialog extends StatelessWidget {
  final Function(CancellationReason) onReasonSelected;

  const CancellationReasonDialog({super.key, required this.onReasonSelected});

  static Future<CancellationReason?> show(
    BuildContext context, {
    required Function(CancellationReason) onReasonSelected,
  }) {
    return showModalBottomSheet<CancellationReason>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          CancellationReasonDialog(onReasonSelected: onReasonSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.85),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkGreyContainer : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header con título y botón cerrar
          _buildHeader(context, isDarkMode),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
          ),

          // Lista de razones
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: CancellationReason.reasons.length,
              itemBuilder: (context, index) {
                final reason = CancellationReason.reasons[index];
                return CancellationReasonOption(
                  reason: reason,
                  onTap: () {
                    Navigator.of(context).pop(reason);
                    onReasonSelected(reason);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '¿Cuál es el motivo de cancelación del viaje?',
              style: TextStyle(
                fontSize: AppTheme.mediumSize + 2,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.close,
                color: isDarkMode ? Colors.white : Colors.black54,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
