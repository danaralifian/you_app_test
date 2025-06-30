class AuthRequest {
  final String email;
  final String password;
  final String username;

  AuthRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    final data = {'email': email, 'password': password, 'username': ''};
    return data;
  }
}
