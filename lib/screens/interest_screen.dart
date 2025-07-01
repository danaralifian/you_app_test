import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/models/user.dart';
import 'package:you_app/modules/user/user_controller.dart';
import 'package:you_app/widgets/gold_text.dart';
import 'package:you_app/widgets/interest_input.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> _interests = [];
  final _userController = Get.find<UserController>();

  void _save() {
    final username = _userController.user.value?.data.username;
    final email = _userController.user.value?.data.email;
    _userController.updateProfile(
      UserModel(
        email: email ?? '',
        username: username ?? '',
        name: _userController.user.value?.data.name ?? '',
        birthday: _userController.user.value?.data.birthday ?? '',
        height: _userController.user.value?.data.height ?? 0,
        weight: _userController.user.value?.data.weight ?? 0,
        horoscope: _userController.user.value?.data.horoscope ?? '',
        zodiac: _userController.user.value?.data.zodiac ?? '',
        interests: _interests,
        gender: _userController.user.value?.data.gender,
        profileImage: _userController.user.value?.data.profileImage ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text('Back', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

                SizedBox(
                  height: 46,
                  child: TextButton(
                    onPressed: _save,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(1.0, -1.2),
            radius: 1.2,
            colors: [Color(0xFF1F4247), Color(0xFF0D1D23), Color(0xFF09141A)],
            stops: [0.0, 0.56, 1.0],
          ),
        ),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              GoldText(
                child: const Text(
                  'Tell everyone about yourself',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'What interest you?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 35),
              Obx(
                () => InterestInput(
                  onChange: (value) {
                    setState(() => _interests = value);
                  },
                  value: _userController.user.value?.data.interests,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
