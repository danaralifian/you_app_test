import 'package:get/get.dart';
import 'package:you_app/modules/auth/auth_service.dart';
import 'package:you_app/modules/auth/models/auth_reponse.dart';
import 'package:you_app/modules/auth/models/auth_request.dart';
import 'package:you_app/routes/app_pages.dart';
import 'package:you_app/utils/logger.dart';

class AuthController extends GetxController {
  // instance of auth service
  final AuthService _authService = AuthService();

  // User data will be stored here
  var user = Rxn<AuthResponse>();

  // loading state
  var isLoading = false.obs;

  // error message
  var error = ''.obs;

  // register user method
  Future<void> register(AuthRequest authRequest) async {
    try {
      isLoading.value = true;

      log.i(
        '{$authRequest.email, $authRequest.username, $authRequest.password  }',
      );

      await _authService.register(authRequest);

      Get.snackbar('Success', 'Registered successfully');
    } catch (e) {
      error.value = 'Registration failed: $e';
      Get.snackbar('Error Registration', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  // login user method
  Future<void> login(AuthRequest authRequest) async {
    try {
      isLoading.value = true;

      user.value = await _authService.login(authRequest);

      Get.snackbar('Success', 'Logged in successfully');
      Get.toNamed(Routes.profile);
    } catch (e) {
      error.value = 'Login failed: $e';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }
}
