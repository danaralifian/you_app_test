import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/models/user_request.dart';
import 'package:you_app/modules/user/models/user_response.dart';

class UserService {
  final Dio _dio = Get.find<Dio>();

  Future<UserResponse> getProfile() async {
    final response = await _dio.get('/getProfile');

    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> createProfile(UserRequest userRequest) async {
    final response = await _dio.post(
      '/createProfile',
      data: {
        'name': userRequest.name,
        'birthday': userRequest.birthday,
        'height': userRequest.height,
        'weight': userRequest.weight,
        'interests': userRequest.interests,
      },
    );

    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> updateProfile(UserRequest userRequest) async {
    final response = await _dio.put(
      '/updateProfile',
      data: {
        'name': userRequest.name,
        'birthday': userRequest.birthday,
        'height': userRequest.height,
        'weight': userRequest.weight,
        'interests': userRequest.interests,
      },
    );

    return UserResponse.fromJson(response.data);
  }
}
