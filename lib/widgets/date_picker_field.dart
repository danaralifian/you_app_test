import 'package:flutter/material.dart';
import 'package:you_app/theme/colors.dart';

class DatePickerField extends StatefulWidget {
  final bool borderless;
  final TextAlign textAlign;
  const DatePickerField({
    this.borderless = false,
    this.textAlign = TextAlign.left,
    super.key,
  });

  @override
  State<DatePickerField> createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerField> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.amber,
              onPrimary: Colors.black,
              surface: Color(0xFF0E191F),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted =
          '${picked.day.toString().padLeft(2, '0')} '
          '${picked.month.toString().padLeft(2, '0')} '
          '${picked.year}';
      _dateController.text = formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(10),
          border: widget.borderless
              ? null
              : Border.all(color: AppColors.borderColor),
        ),
        child: AbsorbPointer(
          child: TextFormField(
            textAlign: widget.textAlign,
            controller: _dateController,
            decoration: const InputDecoration(
              hintText: 'DD MM YYYY',
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
