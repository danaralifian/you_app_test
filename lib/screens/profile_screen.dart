import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/user_controller.dart';
import 'package:you_app/theme/colors.dart';
import 'package:you_app/widgets/about_card.dart';
import 'package:you_app/widgets/interest_card.dart';
import 'package:you_app/widgets/profile_picture_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _userController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_userController.isLoading.value) {
        return const Scaffold(
          backgroundColor: AppColors.background,
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text('Back', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Obx(() {
                    final username = _userController.user.value?.data.username;
                    return Text(
                      '@${username ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ProfilePictureCard(),
                SizedBox(height: 16),
                AboutCard(),
                SizedBox(height: 16),
                InterestCard(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      );
    });
  }
}
