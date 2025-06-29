import 'package:dio/dio.dart';
import 'package:you_app/utils/logger.dart';

class ApiLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.i('➡️ [${options.method}] ${options.uri}');
    log.d('Headers: ${options.headers}');
    log.d('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i('✅ [${response.statusCode}] ${response.requestOptions.uri}');
    log.d('Response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.e('❌ [${err.response?.statusCode}] ${err.requestOptions.uri}');
    log.e('Message: ${err.message}');
    if (err.response != null) {
      log.e('Response Error: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
