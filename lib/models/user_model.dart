class UserResponse {
  final bool success;
  final int? usuarioId;
  final String message;

  UserResponse({required this.success, required this.usuarioId, required this.message});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] ?? false,
      usuarioId: json['usuarioId'] ?? false,
      message: json['mensaje'] ?? '',
    );
  }
}