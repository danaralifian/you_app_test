import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/auth/auth_controller.dart';
import 'package:you_app/utils/dio_logger.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://techtest.youapp.ai/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = Get.find<AuthController>().user.value?.accessToken;

          if (token != null && token.isNotEmpty) {
            options.headers['x-access-token'] = token;
          }

          return handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(ApiLogger());
    }
    return dio;
  }
}
