import 'package:flutter/material.dart';
import 'package:you_app/theme/colors.dart';

class InputTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final bool borderless;
  final TextAlign textAlign;
  final bool enabled;
  final String? value;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const InputTextField({
    super.key,
    this.value,
    this.labelText = '',
    this.hintText = '',
    this.isPassword = false,
    this.borderless = false,
    this.textAlign = TextAlign.left,
    this.enabled = true,
    this.onChanged,
    this.validator,
    required this.controller,
  });

  @override
  State<InputTextField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<InputTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      textAlign: widget.textAlign,
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      obscuringCharacter: '*',
      validator: widget.validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: AppColors.inputFill,
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: widget.borderless
              ? BorderSide.none
              : BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: widget.borderless
              ? BorderSide.none
              : BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: widget.borderless
              ? BorderSide.none
              : BorderSide(color: AppColors.borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment(-1, 0),
                    end: Alignment(1, 0),
                    colors: [
                      Color(0xFF94783E),
                      Color(0xFFF3EDA6),
                      Color(0xFFF8FAE5),
                      Color(0xFFFFE2BE),
                      Color(0xFFD5BE88),
                      Color(0xFFF8FAE5),
                      Color(0xFFD5BE88),
                    ],
                    stops: [0.0, 0.16, 0.30, 0.49, 0.78, 0.89, 1.0],
                  ).createShader(bounds),
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
