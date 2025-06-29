import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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

                // Center username
                const Text(
                  '@johndoe',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // More icon
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                  onPressed: () {
                    // Open menu
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: const [
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
  }
}
