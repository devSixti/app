/// Modelo que representa el perfil del usuario
class UserProfile {
  final String fullName;
  final String phoneNumber;
  final String location;
  final String? avatarUrl;

  const UserProfile({
    required this.fullName,
    required this.phoneNumber,
    required this.location,
    this.avatarUrl,
  });

  UserProfile copyWith({
    String? fullName,
    String? phoneNumber,
    String? location,
    String? avatarUrl,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}