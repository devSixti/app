/// Modelo que representa la calificación de un conductor
class DriverRating {
  final String driverName;
  final double rating;
  final String? avatarUrl;

  const DriverRating({
    required this.driverName,
    required this.rating,
    this.avatarUrl,
  });
}