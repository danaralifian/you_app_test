import 'package:flutter/material.dart';
import 'package:you_app/theme/colors.dart';

class SelectField extends StatefulWidget {
  final String? hintText;
  final String? value;
  final void Function(String?)? onChange;
  final List<DropdownMenuItem<String>>? items;
  final bool borderless;
  final Alignment alignment;

  const SelectField({
    this.value,
    this.onChange,
    this.items,
    this.hintText,
    this.borderless = false,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  @override
  State<SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(10),
        border: widget.borderless
            ? null
            : Border.all(color: AppColors.borderColor),
      ),
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          alignment: widget.alignment,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: Colors.white),
          value: widget.value,
          hint: Text(
            widget.hintText ?? 'Select',
            style: TextStyle(color: Colors.grey),
          ),
          items: widget.items,
          onChanged: widget.onChange,
          style: const TextStyle(color: Colors.white),
          elevation: 5,
          dropdownColor: AppColors.cardInfoDark,
        ),
      ),
    );
  }
}
