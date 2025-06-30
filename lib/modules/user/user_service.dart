import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/models/user.dart';
import 'package:you_app/modules/user/models/user_response.dart';

class UserService {
  final Dio _dio = Get.find<Dio>();

  Future<UserResponse> getProfile() async {
    final response = await _dio.get('/getProfile');

    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> createProfile(UserModel user) async {
    final response = await _dio.post(
      '/createProfile',
      data: {
        'name': user.name,
        'birthday': user.birthday,
        'height': user.height,
        'weight': user.weight,
        'interests': user.interests,
      },
    );

    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> updateProfile(UserModel user) async {
    final response = await _dio.put(
      '/updateProfile',
      data: {
        'name': user.name,
        'birthday': user.birthday,
        'height': user.height,
        'weight': user.weight,
        'interests': user.interests,
      },
    );

    return UserResponse.fromJson(response.data);
  }
}
