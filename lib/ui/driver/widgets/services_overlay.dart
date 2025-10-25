import 'package:flutter/material.dart';
// Theme not required here; kept minimal to keep file short.
import 'service_notification.dart';

class ServicesOverlay extends StatelessWidget {
  const ServicesOverlay({
    required this.services,
    required this.listKey,
    required this.onAccept,
    required this.onReject,
    required this.onTimeout,
    super.key,
  });

  final List<Map<String, dynamic>> services;
  final GlobalKey<AnimatedListState> listKey;
  final void Function(int id) onAccept;
  final void Function(int id) onReject;
  final void Function(int id) onTimeout;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        alignment: Alignment.topCenter,
        child: AnimatedList(
          key: listKey,
          initialItemCount: services.length,
          itemBuilder: (context, index, animation) {
            final s = services[index];
            return Column(
              children: [
                SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0.6, 0.0), end: Offset.zero)
                      .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
                  child: FadeTransition(
                    opacity: animation,
                    child: ServiceNotification(
                      key: ValueKey(s['id'] as int),
                      serviceData: s,
                      onTimeout: () => onTimeout(s['id'] as int),
                      onAccept: () => onAccept(s['id'] as int),
                      onReject: () => onReject(s['id'] as int),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
