import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/user_controller.dart';
import 'package:you_app/theme/colors.dart';
import 'package:you_app/utils/horoscope_and_zodiac.dart';
import 'package:you_app/widgets/zodiac_badge.dart';

class ProfilePictureCard extends StatefulWidget {
  const ProfilePictureCard({super.key});

  @override
  State<ProfilePictureCard> createState() => _ProfilePictureCardState();
}

class _ProfilePictureCardState extends State<ProfilePictureCard> {
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        color: AppColors.backgroundProfilePictureCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Wrap(
              spacing: 6,
              direction: Axis.vertical,
              children: [
                Obx(
                  () => Text(
                    '@${_userController.user.value?.data.username ?? ''}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                Obx(
                  () => _userController.user.value?.data.gender?.isEmpty ?? true
                      ? const Text('')
                      : Text(
                          _userController.user.value?.data.gender ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                Obx(
                  () => Wrap(
                    spacing: 15,
                    children: [
                      ZodiacBadge(
                        label: _userController.user.value?.data.horoscope ?? '',
                        icon:
                            getZodiacIcon(
                              _userController.user.value?.data.horoscope ?? '',
                            )["icon"] ??
                            '',
                      ),
                      ZodiacBadge(
                        label: _userController.user.value?.data.zodiac ?? '',
                        icon:
                            getZodiacIcon(
                              _userController.user.value?.data.zodiac ?? '',
                            )["icon"] ??
                            '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
