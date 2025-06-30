class UserResponse {
  final String message;
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;
  final List<String>? interests;

  UserResponse({
    required this.message,
    required this.email,
    required this.username,
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'],
      email: json['email'],
      username: json['username'],
      name: json['name'] ?? '',
      birthday: json['birthday'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      interests: json['interests']?.cast<String>() ?? [],
    );
  }
}
