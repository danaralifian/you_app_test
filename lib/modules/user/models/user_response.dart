import 'package:you_app/modules/user/models/user.dart';

class UserResponse {
  final String message;
  final UserModel data;

  UserResponse({required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return UserResponse(
      message: json['message'],
      data: UserModel.fromJson(data),
    );
  }
}
