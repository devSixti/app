import 'dart:math';
import 'package:flutter/material.dart';
import 'service_notification.dart';

class ServicesManager extends StatefulWidget {
  const ServicesManager({
    required this.isDriverActive,
    required this.onAccepted,
    super.key,
  });

  final bool isDriverActive;
  final VoidCallback onAccepted;

  @override
  ServicesManagerState createState() => ServicesManagerState();
}

class ServicesManagerState extends State<ServicesManager> {
  final List<Map<String, dynamic>> services = [];
  int _serviceCounter = 0;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  void addSimulatedService(BuildContext context) {
    if (!widget.isDriverActive) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Estás ocupado. No puedes recibir simulaciones.')));
      return;
    }

    final id = DateTime.now().millisecondsSinceEpoch * 1000 + (_serviceCounter++);
    final random = Random();
    final timeoutValue = 8 + random.nextInt(4);
    final startTimeMs = DateTime.now().millisecondsSinceEpoch;

    final service = {
      'id': id,
      'pickUp': 'Punto de simulación',
      'destination': 'Destino simulado',
      'price': '12000',
      'distance': '4.2',
      'userName': 'Simulado',
      'userRating': 4.8,
      'ratingCount': 5,
      'payMethod': 'nequi',
      'timeout': timeoutValue,
      'startTime': startTimeMs,
      'requestTime': 1,
    };

    final insertIndex = services.length;
    setState(() => services.add(service));
    listKey.currentState?.insertItem(insertIndex, duration: const Duration(milliseconds: 700));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Servicio de simulación agregado')));
  }

  void _removeServiceById(int id) {
    final index = services.indexWhere((s) => s['id'] == id);
    if (index == -1) return;
    final removed = services.removeAt(index);
    if (listKey.currentState != null) {
      listKey.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(sizeFactor: animation, child: ServiceNotification(serviceData: removed)),
        duration: const Duration(milliseconds: 700),
      );
      setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();

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
                      onTimeout: () => _removeServiceById(s['id'] as int),
                      onAccept: () {
                        widget.onAccepted();
                        _removeServiceById(s['id'] as int);
                      },
                      onReject: () {
                        _removeServiceById(s['id'] as int);
                      },
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
