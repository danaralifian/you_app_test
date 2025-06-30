import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/user/user_controller.dart';
import 'package:you_app/screens/interest_screen.dart';
import 'package:you_app/theme/colors.dart';
import 'package:you_app/widgets/interest_tags.dart';

class InterestCard extends StatefulWidget {
  const InterestCard({super.key});

  @override
  State<InterestCard> createState() => _InterestCardState();
}

class _InterestCardState extends State<InterestCard> {
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isUserInterestEmpty =
          _userController.user.value?.data.interests?.isEmpty ?? true;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        //height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardInfoDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Interest',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InterestScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: isUserInterestEmpty ? 28 : 24),
            isUserInterestEmpty
                ? Text(
                    'Add in your interest to find a better match',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.52),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : InterestTags(
                    tags: _userController.user.value?.data.interests ?? [],
                  ),
            SizedBox(height: 16),
          ],
        ),
      );
    });
  }
}
