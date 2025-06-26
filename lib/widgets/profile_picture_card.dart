import 'package:flutter/material.dart';
import 'package:you_app/theme/colors.dart';

class ProfilePictureCard extends StatefulWidget {
  const ProfilePictureCard({super.key});

  @override
  State<ProfilePictureCard> createState() => _ProfilePictureCardState();
}

class _ProfilePictureCardState extends State<ProfilePictureCard> {
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
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.white, size: 20),
              onPressed: () {},
            ),
          ),
          Positioned(bottom: 16, left: 16, child: Text('@John Doe')),
        ],
      ),
    );
  }
}
