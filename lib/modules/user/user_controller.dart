import 'package:get/get.dart';
import 'package:you_app/modules/user/models/user_request.dart';
import 'package:you_app/modules/user/models/user_response.dart';
import 'package:you_app/modules/user/user_service.dart';
import 'package:you_app/routes/app_pages.dart';

class UserController extends GetxController {
  // instance of user service
  final UserService _userService = UserService();

  // User data will be stored here
  var user = Rxn<UserResponse>();

  // loading state
  var isLoading = false.obs;

  // error message
  var error = ''.obs;

  // get user profile method
  Future<void> getProfile() async {
    try {
      isLoading.value = true;

      await _userService.getProfile();

      Get.snackbar('Success', 'Registered successfully');
    } catch (e) {
      error.value = 'Registration failed: $e';
      Get.snackbar('Error Registration', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  // create user profile method
  Future<void> createProfile(UserRequest userRequest) async {
    try {
      isLoading.value = true;

      user.value = await _userService.createProfile(userRequest);

      Get.snackbar('Success', 'Saved successfully');
      Get.toNamed(Routes.profile);
    } catch (e) {
      error.value = 'Save failed: $e';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(UserRequest userRequest) async {
    try {
      isLoading.value = true;

      user.value = await _userService.updateProfile(userRequest);

      Get.snackbar('Success', 'Saved successfully');
      Get.toNamed(Routes.profile);
    } catch (e) {
      error.value = 'Update failed: $e';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }
}
