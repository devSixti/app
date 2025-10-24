class IncomingService {
  final String passengerName;
  final String from;
  final String to;
  final double fare;
  final String id;
  final double? rating;
  final String? paymentMethod;
  final DateTime? createdAt;

  IncomingService({
    required this.passengerName,
    required this.from,
    required this.to,
    required this.fare,
    this.rating,
    this.paymentMethod,
    this.createdAt,
    String? id,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();
}
