class UserRequest {
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;
  final List<String>? interests;

  UserRequest({
    required this.email,
    required this.username,
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
  });

  Map<String, dynamic> toJson() {
    final data = {
      'email': email,
      'username': username,
      'name': name,
      'birthday': birthday,
      'height': height,
      'weight': weight,
      'interests': interests,
    };
    return data;
  }
}
