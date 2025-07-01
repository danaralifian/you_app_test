import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/auth/models/auth_reponse.dart';
import 'package:you_app/modules/auth/models/auth_request.dart';

class AuthService {
  final Dio _dio = Get.find<Dio>();

  Future<AuthResponse> register(AuthRequest authRequest) async {
    await _dio.post(
      '/register',
      data: {
        'email': authRequest.email,
        'username': authRequest.username,
        'password': authRequest.password,
      },
    );

    final response = await login(authRequest);

    return response;
  }

  Future<AuthResponse> login(AuthRequest authRequest) async {
    final response = await _dio.post(
      '/login',
      data: {
        'email': authRequest.email,
        'password': authRequest.password,
        'username': authRequest.username,
      },
    );

    return AuthResponse.fromJson(response.data);
  }
}
