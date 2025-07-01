import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/user_controller.dart';
import 'package:you_app/routes/app_pages.dart';
import 'package:you_app/theme/colors.dart';
import 'package:you_app/utils/logger.dart';
import 'package:you_app/widgets/interest_tags.dart';

class InterestCard extends StatelessWidget {
  InterestCard({super.key});

  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final interests = _userController.user.value?.data.interests ?? [];
      final isUserInterestEmpty = interests.isEmpty;

      log.i('isUserInterestEmpty: $interests');

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cardInfoDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Interest',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                  onPressed: () {
                    Get.toNamed(Routes.interestForm);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            isUserInterestEmpty
                ? const Text(
                    'Add in your interest to find a better match',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.52),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : InterestTags(tags: interests),

            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }
}
