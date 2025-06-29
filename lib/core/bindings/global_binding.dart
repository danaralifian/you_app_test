import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => DioClient.create());
  }
}
