class AuthRequest {
  final String email;
  final String password;
  final String? username; // optional for login

  AuthRequest({required this.email, required this.password, this.username});

  Map<String, dynamic> toJson() {
    final data = {'email': email, 'password': password};
    if (username != null) data['username'] = username ?? '';
    return data;
  }
}
