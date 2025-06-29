import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

    if (kDebugMode) {
      dio.interceptors.add(ApiLogger());
    }
    return dio;
  }
}
