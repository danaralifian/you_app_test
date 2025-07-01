import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:you_app/modules/user/models/user.dart';
import 'package:you_app/modules/user/user_controller.dart';
import 'package:you_app/theme/colors.dart';
import 'package:you_app/utils/date.dart';
import 'package:you_app/utils/horoscope_and_zodiac.dart';
import 'package:you_app/utils/logger.dart';
import 'package:you_app/widgets/add_image_profile.dart';
import 'package:you_app/widgets/date_picker_field.dart';
import 'package:you_app/widgets/gold_text.dart';
import 'package:you_app/widgets/input_text_field.dart';
import 'package:you_app/widgets/profile_info.dart';
import 'package:you_app/widgets/select_field.dart';

class AboutCard extends StatefulWidget {
  const AboutCard({super.key});

  @override
  State<AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {
  bool isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _horoscopeController = TextEditingController();
  final TextEditingController _zodiacController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String? selectedGender;
  final _userController = Get.find<UserController>();
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _birthdayController.addListener(_setHoroscopeAndZodiac);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = _userController.user.value?.data;
      if (data != null) _fillForm(data);

      ever(_userController.user, (user) {
        final data = user?.data;
        if (data != null) _fillForm(data);
      });
    });
  }

  void _fillForm(UserModel data) {
    _nameController.text = data.name ?? '';
    _birthdayController.text = data.birthday ?? '';
    _horoscopeController.text = data.horoscope ?? '';
    _zodiacController.text = data.zodiac ?? '';
    selectedGender = data.gender;
    _heightController.text = data.height?.toString() ?? '';
    _weightController.text = data.weight?.toString() ?? '';
    profileImage = data.profileImage;
  }

  void _setHoroscopeAndZodiac() {
    final text = _birthdayController.text.trim();

    if (text.isEmpty) return;

    try {
      final birthDate = DateFormat("dd MM yyyy").parse(text);
      final result = getHoroscopeAndZodiac(birthDate);

      _horoscopeController.text = result['horoscope'] ?? '';
      _zodiacController.text = result['zodiac'] ?? '';
    } catch (e) {
      log.i('Invalid birthday format: $text');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _horoscopeController.dispose();
    _zodiacController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _saveAndUpdate() {
    _userController.updateProfile(
      UserModel(
        email: _userController.user.value!.data.email,
        username: _userController.user.value!.data.username,
        name: _nameController.text,
        interests: _userController.user.value!.data.interests,
        birthday: _birthdayController.text,
        gender: selectedGender,
        height: int.tryParse(_heightController.text),
        weight: int.tryParse(_weightController.text),
        horoscope: _horoscopeController.text,
        zodiac: _zodiacController.text,
        profileImage: profileImage,
      ),
    );

    setState(() => isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    final bool isProfileComplete =
        _userController.user.value?.data.name != null;

    Widget buildInput({required String label, Widget? child}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '$label:',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(child: child ?? const SizedBox()),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardInfoDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: isEditing
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: _saveAndUpdate,
                      child: GoldText(
                        child: const Text(
                          'Save & Update',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Avatar
                AddImageProfile(
                  onChange: (value) {
                    setState(() => profileImage = value);
                  },
                ),
                const SizedBox(height: 24),

                // Form fields
                buildInput(
                  label: 'Display name',
                  child: InputTextField(
                    controller: _nameController,
                    hintText: 'Enter name',
                    textAlign: TextAlign.right,
                  ),
                ),
                buildInput(
                  label: 'Gender',
                  child: SelectField(
                    value: selectedGender,
                    hintText: 'Select Gender',
                    alignment: Alignment.centerRight,
                    items: [
                      DropdownMenuItem(
                        value: 'Male',
                        alignment: Alignment.centerRight,
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        alignment: Alignment.centerRight,
                        child: Text('Female'),
                      ),
                    ],
                    onChange: (value) {
                      setState(() => selectedGender = value);
                    },
                  ),
                ),
                buildInput(
                  label: 'Birthday',
                  child: DatePickerField(
                    textAlign: TextAlign.right,
                    controller: _birthdayController,
                  ),
                ),
                buildInput(
                  label: 'Horoscope',
                  child: InputTextField(
                    controller: _horoscopeController,
                    textAlign: TextAlign.right,
                    enabled: false,
                    hintText: '--',
                  ),
                ),
                buildInput(
                  label: 'Zodiac',
                  child: InputTextField(
                    controller: _zodiacController,
                    textAlign: TextAlign.right,
                    enabled: false,
                    hintText: '--',
                  ),
                ),
                buildInput(
                  label: 'Height',
                  child: InputTextField(
                    controller: _heightController,
                    textAlign: TextAlign.right,
                    hintText: 'Add height',
                    suffixText: 'cm',
                  ),
                ),
                buildInput(
                  label: 'Weight',
                  child: InputTextField(
                    controller: _weightController,
                    textAlign: TextAlign.right,
                    hintText: 'Add weight',
                    suffixText: 'kg',
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (view mode)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() => isEditing = true);
                      },
                    ),
                  ],
                ),
                SizedBox(height: isProfileComplete ? 24 : 28),
                isProfileComplete
                    ? Obx(() {
                        final user = _userController.user.value?.data;
                        if (user == null) return SizedBox();

                        final birthdayString = user.birthday;

                        return ProfileInfo(
                          birthday: parseBirthday(birthdayString),
                          horoscope: user.horoscope ?? '',
                          zodiac: user.zodiac ?? '',
                          height: user.height,
                          weight: user.weight,
                        );
                      })
                    : const Text(
                        'Add in your your to help others know you better',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.52),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ],
            ),
    );
  }
}
