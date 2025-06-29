import 'package:get/get.dart';
import 'package:you_app/screens/auth_screen.dart';
import '../modules/auth/auth_binding.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.auth,
      page: () => const AuthScreen(),
      bindings: [AuthBinding()],
    ),
  ];
}
