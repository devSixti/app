import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/app_theme.dart';

class IncomingServiceCard extends StatefulWidget {
  final String passengerName;
  final String from;
  final String to;
  final double fare;
  final double? rating;
  final String paymentMethod;
  final DateTime? createdAt;
  final Duration timeout;
  final void Function() onAccept;
  final void Function() onDecline;

  const IncomingServiceCard({
    super.key,
    required this.passengerName,
    required this.from,
    required this.to,
    required this.fare,
    this.rating,
    this.paymentMethod = 'Efectivo',
    required this.onAccept,
    required this.onDecline,
    this.timeout = const Duration(seconds: 15),
    this.createdAt,
  });

  @override
  State<IncomingServiceCard> createState() => _IncomingServiceCardState();
}

class _IncomingServiceCardState extends State<IncomingServiceCard> {
  late int _remaining;
  Timer? _timer;
  late int _totalSeconds;
  DateTime? _createdAt;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.timeout.inSeconds;
    _createdAt = widget.createdAt ?? DateTime.now();
    final elapsed = DateTime.now().difference(_createdAt!).inSeconds;
    _remaining = max(0, _totalSeconds - elapsed);

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _remaining = _remaining - 1;
        if (_remaining <= 0) {
          _timer?.cancel();
          widget.onDecline();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.darkGreyContainer,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 12),
                // Expandimos la columna de texto para que las direcciones no provoquen overflow
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.passengerName,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.rating != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.yellow, size: 14),
                                  const SizedBox(width: 4),
                                  Text(widget.rating!.toStringAsFixed(1), style: const TextStyle(color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                          ]
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Mostrar ubicaciones en una sola línea con scroll horizontal para evitar crecer verticalmente
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Bolita verde para origen
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor),
                            ),
                            const SizedBox(width: 8),
                            Text(widget.from, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Bolita morada para destino
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.purpleColor),
                            ),
                            const SizedBox(width: 8),
                            Text(widget.to, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Mostrar tarifa formateada como COP (usamos FittedBox para evitar overflow)
                    SizedBox(
                      width: 110,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          'COP ${NumberFormat.decimalPattern('es_CO').format(widget.fare.toInt())}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Método de pago
            Text('Método de pago: ${widget.paymentMethod}', style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12)),
            const SizedBox(height: 8),

            // Barra de progreso de ancho completo colocada encima de los botones
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: (_totalSeconds > 0) ? (_remaining / _totalSeconds) : 0,
                      backgroundColor: Colors.white12,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.purpleColor),
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Segundos restantes a la derecha de la barra
                SizedBox(
                  width: 48,
                  child: Text('${_remaining}s', style: const TextStyle(color: AppTheme.purpleColor, fontSize: 12), textAlign: TextAlign.right),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _timer?.cancel();
                      widget.onAccept();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                    child: const Text('Aceptar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _timer?.cancel();
                      widget.onDecline();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.purpleColor,
                    ),
                    child: const Text('Rechazar', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
