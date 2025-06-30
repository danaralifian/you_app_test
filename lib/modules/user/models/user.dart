class UserModel {
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;
  final List<String>? interests;

  UserModel({
    required this.email,
    required this.username,
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      name: json['name'],
      birthday: json['birthday'],
      height: json['height'],
      weight: json['weight'],
      interests: List<String>.from(json['interests'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'username': username,
    'name': name,
    'birthday': birthday,
    'height': height,
    'weight': weight,
    'interests': interests,
  };
}
