import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ServiceNotification extends StatefulWidget {
  const ServiceNotification({
    required this.serviceData,
    this.onTimeout,
    this.onAccept,
    this.onReject,
    super.key,
  });

  final Map<String, dynamic> serviceData;
  final VoidCallback? onTimeout;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  @override
  State<ServiceNotification> createState() => _ServiceNotificationState();
}

class _ServiceNotificationState extends State<ServiceNotification> {
  Timer? _progressTimer;
  double _progress = 0.0;
  late final int _timeoutSeconds;
  late final DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _timeoutSeconds = (widget.serviceData['timeout'] is int)
        ? widget.serviceData['timeout'] as int
        : 8;
    if (widget.serviceData.containsKey('startTime')) {
      final v = widget.serviceData['startTime'];
      if (v is int) {
        _startTime = DateTime.fromMillisecondsSinceEpoch(v);
      } else {
        _startTime = DateTime.now();
      }
    } else {
      _startTime = DateTime.now();
    }

    final totalMs = _timeoutSeconds * 1000;

    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      final elapsed = DateTime.now().difference(_startTime).inMilliseconds;
      final p = (elapsed / totalMs).clamp(0.0, 1.0);
      if (mounted) {
        setState(() {
          _progress = p;
        });
      }
      if (elapsed >= totalMs) {
        // ignore: avoid_print
        print('ServiceNotification timeout completed id=${widget.serviceData['id']}');
        widget.onTimeout?.call();
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  Widget _buildPayMethodBadge(dynamic payMethod) {
    final method = (payMethod ?? '').toString().toLowerCase();
    IconData icon;
    String label;
    Color bg = AppTheme.inputBackgroundDark;

    switch (method) {
      case 'nequi':
        icon = Icons.account_balance_wallet;
        label = 'Nequi';
        bg = AppTheme.primaryColor;
        break;
      case 'tarjeta':
      case 'card':
      case 'credit':
        icon = Icons.credit_card;
        label = 'Tarjeta';
        bg = AppTheme.primaryColor;
        break;
      case 'efectivo':
      case 'cash':
      default:
        icon = Icons.money;
        label = 'Efectivo';
        bg = AppTheme.primaryColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black87),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.black87, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => _showServiceDetails(context, widget.serviceData),
        child: Container(
          margin: EdgeInsets.only(bottom: size.height * 0.008),
          padding: EdgeInsets.all(size.width * 0.04),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(21, 21, 21, 0.97),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                minHeight: 3,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            const Icon(Icons.place, color: Colors.green, size: 16),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                widget.serviceData['pickUp'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.flag, color: Colors.purple, size: 16),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                widget.serviceData['destination'],
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: size.width * 0.033,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '\$${_formatNumber(int.parse(widget.serviceData['price']))} COP',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('~${widget.serviceData['distance']} km', style: TextStyle(color: Colors.white70)),
                            const SizedBox(width: 10),
                            _buildPayMethodBadge(widget.serviceData['payMethod']),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: widget.onAccept,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('Aceptar'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: widget.onReject,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.purpleColor,
                                  foregroundColor: Colors.black,
                                ),
                                child: const Text('Rechazar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.06,
                        backgroundColor: AppTheme.inputBackgroundDark,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.serviceData['userName'],
                        style: TextStyle(color: Colors.white70, fontSize: size.width * 0.03),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          Text('${widget.serviceData['userRating']}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _showServiceDetails(BuildContext context, Map<String, dynamic> serviceData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.inputBackgroundDark,
          title: const Text('Detalles del servicio', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Usuario: ${serviceData['userName']}', style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Text('\$${_formatNumber(int.parse(serviceData['price']))} COP', style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Text('Distancia: ${serviceData['distance']} km', style: const TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Rechazar', style: TextStyle(color: Colors.black))),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onAccept?.call();
              },
              child: const Text('Aceptar', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}
