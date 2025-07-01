import 'dart:io';

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
    return Obx(() {
      final profileImage = _userController.user.value?.data.profileImage ?? '';

      return Container(
        width: double.infinity,
        height: 190,
        decoration: BoxDecoration(
          color: AppColors.backgroundProfilePictureCard,
          borderRadius: BorderRadius.circular(16),
          image: profileImage.isEmpty
              ? null
              : DecorationImage(
                  image: FileImage(File(profileImage)),
                  fit: BoxFit.cover,
                ),
        ),
        child: Stack(
          children: [
            if (profileImage.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.76),
                      Color.fromRGBO(0, 0, 0, 0),
                      Color.fromRGBO(0, 0, 0, 0.76),
                    ],
                    stops: [0.0, 0.4583, 1.0],
                  ),
                ),
              ),
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Obx(
                    () =>
                        (_userController.user.value?.data.gender?.isEmpty ??
                            true)
                        ? const SizedBox()
                        : Text(
                            _userController.user.value?.data.gender ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Obx(
                    () => Wrap(
                      spacing: 15,
                      children: [
                        ZodiacBadge(
                          label:
                              _userController.user.value?.data.horoscope ?? '',
                          icon:
                              getZodiacIcon(
                                _userController.user.value?.data.horoscope ??
                                    '',
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
    });
  }
}
