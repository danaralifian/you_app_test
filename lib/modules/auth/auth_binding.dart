import 'package:get/get.dart';
import 'package:you_app/modules/auth/auth_controller.dart';
import 'package:you_app/modules/auth/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => AuthController());
  }
}
