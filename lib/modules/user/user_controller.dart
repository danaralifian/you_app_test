import 'package:get/get.dart';
import 'package:you_app/modules/user/models/user.dart';
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

      user.value = await _userService.getProfile();
    } catch (e) {
      error.value = 'Get profile failed: $e';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  // create user profile method
  Future<void> createProfile(UserModel userRequest) async {
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

  Future<void> updateProfile(UserModel userRequest) async {
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
