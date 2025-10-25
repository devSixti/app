// Botón para cancelar la solicitud

import 'package:app/ui/searching_driver/widgets/cancellation/cancellation_reason.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class CancelRequestButton extends StatelessWidget {
  final Function(CancellationReason) onCancellationConfirmed;

  const CancelRequestButton({
    super.key,
    required this.onCancellationConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showCancellationDialog(context),
      child: const Text(
        'Cancelar solicitud',
        style: TextStyle(
          fontSize: AppTheme.mediumSize,
          color: AppTheme.purpleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showCancellationDialog(BuildContext context) {
    CancellationReasonDialog.show(
      context,
      onReasonSelected: (reason) {
        // Llamar al callback con la razón seleccionada
        onCancellationConfirmed(reason);
      },
    );
  }
}
