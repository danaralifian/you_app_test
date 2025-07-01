import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/user_controller.dart';
import 'package:you_app/theme/colors.dart';
import 'package:you_app/utils/age.dart';
import 'package:you_app/utils/date.dart';
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
      final birthday = parseBirthday(_userController.user.value?.data.birthday);
      final age = calculateAge(birthday);
      final horoscope = _userController.user.value?.data.horoscope;
      final zodiac = _userController.user.value?.data.zodiac;
      final gender = _userController.user.value?.data.gender;

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
                spacing:
                    (horoscope?.isEmpty ?? true) &&
                        (zodiac?.isEmpty ?? true) &&
                        (gender?.isEmpty ?? true)
                    ? 0
                    : 6,
                direction: Axis.vertical,
                children: [
                  Obx(
                    () => Text(
                      '@${_userController.user.value?.data.username ?? ''} ${age != null ? ', $age' : ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  (_userController.user.value?.data.gender?.isEmpty ?? true)
                      ? const SizedBox.shrink()
                      : Text(
                          _userController.user.value?.data.gender ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                  Wrap(
                    spacing: 15,
                    children: [
                      horoscope?.isEmpty ?? true
                          ? const SizedBox()
                          : ZodiacBadge(
                              label: horoscope ?? '',
                              icon:
                                  getZodiacIcon(horoscope ?? '')["icon"] ?? '',
                            ),
                      zodiac?.isEmpty ?? true
                          ? const SizedBox()
                          : ZodiacBadge(
                              label: zodiac ?? '',
                              icon: getZodiacIcon(zodiac ?? '')["icon"] ?? '',
                            ),
                    ],
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
