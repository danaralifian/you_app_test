class AuthResponse {
  final String message;
  final String? accessToken;

  AuthResponse({required this.message, this.accessToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'] ?? '',
      accessToken: json['access_token'], // can be null
    );
  }
}
