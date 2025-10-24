import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';

class WaitingSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final int waitingDots;
  final VoidCallback onDisconnect;

  const WaitingSheet({super.key, required this.controller, required this.waitingDots, required this.onDisconnect});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0.14,
      minChildSize: 0.10,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.darkDrawerBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(1)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    height: 67,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: AppTheme.blackContainer,
                        shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        minimumSize: const Size.fromHeight(67),
                      ),
                      child: Text('Esperando${'.' * waitingDots}', textAlign: TextAlign.center, style: const TextStyle(fontSize: AppTheme.mediumSize, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(height: 160),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.45),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: ElevatedButton(
                            onPressed: onDisconnect,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.purpleColor,
                              foregroundColor: AppTheme.blackContainer,
                              shape: const CircleBorder(),
                              padding: EdgeInsets.zero,
                              elevation: 4,
                            ),
                            child: const Icon(Icons.power_settings_new, size: 28),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text('Desconectar', style: TextStyle(color: AppTheme.whiteContainer, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
