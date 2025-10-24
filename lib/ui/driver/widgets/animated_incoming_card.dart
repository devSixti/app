import 'package:flutter/material.dart';
import 'package:app/ui/driver/models/incoming_service.dart';
import 'package:app/ui/driver/widgets/incoming_service_card.dart';

class AnimatedIncomingCard extends StatefulWidget {
  final IncomingService service;
  final Duration duration;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const AnimatedIncomingCard({
    super.key,
    required this.service,
    required this.duration,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  State<AnimatedIncomingCard> createState() => _AnimatedIncomingCardState();
}

class _AnimatedIncomingCardState extends State<AnimatedIncomingCard> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _offsetAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _offsetAnim = Tween(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _hideAndThen(VoidCallback cb) async {
    await _ctrl.reverse();
    cb();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnim,
      child: IncomingServiceCard(
        passengerName: widget.service.passengerName,
        from: widget.service.from,
        to: widget.service.to,
        fare: widget.service.fare,
        createdAt: widget.service.createdAt,
        rating: widget.service.rating,
        onAccept: () => _hideAndThen(widget.onAccept),
        onDecline: () => _hideAndThen(widget.onDecline),
      ),
    );
  }
}
