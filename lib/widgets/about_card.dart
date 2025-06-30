import 'package:flutter/material.dart';
import 'package:you_app/theme/colors.dart';
import 'package:you_app/widgets/date_picker_field.dart';
import 'package:you_app/widgets/input_text_field.dart';
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
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    const inputFill = Color.fromRGBO(255, 255, 255, 0.06);

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
                      onPressed: () {
                        setState(() => isEditing = false);
                      },
                      child: const Text(
                        'Save & Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Avatar
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: inputFill,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFFF3EDA6),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Add image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Form fields
                buildInput(
                  label: 'Display name',
                  child: InputTextField(
                    controller: _nameController,
                    hintText: 'Enter name',
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      _horoscopeController.text = value;
                    },
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
                    onChanged: (value) {
                      setState(() => selectedGender = value);
                    },
                  ),
                ),
                buildInput(
                  label: 'Birthday',
                  child: DatePickerField(textAlign: TextAlign.right),
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
                  ),
                ),
                buildInput(
                  label: 'Weight',
                  child: InputTextField(
                    controller: _weightController,
                    textAlign: TextAlign.right,
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
                const SizedBox(height: 28),
                const Text(
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
