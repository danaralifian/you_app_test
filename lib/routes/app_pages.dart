import 'package:get/get.dart';
import 'package:you_app/modules/user/user_binding.dart';
import 'package:you_app/screens/auth_screen.dart';
import 'package:you_app/screens/interest_screen.dart';
import 'package:you_app/screens/profile_screen.dart';
import '../modules/auth/auth_binding.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.auth,
      page: () => const AuthScreen(),
      bindings: [AuthBinding()],
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      bindings: [UserBinding()],
    ),
    GetPage(
      name: Routes.interestForm,
      page: () => const InterestScreen(),
      bindings: [UserBinding()],
    ),
  ];
}
