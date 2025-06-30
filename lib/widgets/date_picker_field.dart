import 'package:flutter/material.dart';
import 'package:you_app/theme/colors.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController? controller;
  final bool borderless;
  final TextAlign textAlign;

  const DatePickerField({
    this.borderless = false,
    this.textAlign = TextAlign.left,
    super.key,
    this.controller,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose(); // Only dispose if it's internal
    }
    super.dispose();
  }

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
      _controller.text = formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
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
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'DD MM YYYY',
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
