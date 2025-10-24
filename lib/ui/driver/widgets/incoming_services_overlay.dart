import 'package:flutter/material.dart';
import 'package:app/ui/driver/models/incoming_service.dart';
import 'package:app/ui/driver/widgets/animated_incoming_card.dart';

class IncomingServicesOverlay extends StatelessWidget {
  final List<IncomingService> services;
  final Duration animDuration;
  final void Function(IncomingService) onAccept;
  final void Function(IncomingService) onDecline;

  const IncomingServicesOverlay({
    super.key,
    required this.services,
    required this.animDuration,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      top: MediaQuery.of(context).viewPadding.top + 12,
      bottom: 16,
      child: SafeArea(
        top: false,
        child: ListView.separated(
          shrinkWrap: false,
          physics: const BouncingScrollPhysics(),
          itemCount: services.length,
          padding: const EdgeInsets.only(bottom: 12),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final svc = services[index];
            return AnimatedIncomingCard(
              key: ValueKey(svc.id),
              service: svc,
              duration: animDuration,
              onAccept: () => onAccept(svc),
              onDecline: () => onDecline(svc),
            );
          },
        ),
      ),
    );
  }
}
