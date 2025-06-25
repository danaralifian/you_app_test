import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const InputTextField({
    super.key,
    this.labelText = '',
    this.hintText = '',
    this.isPassword = false,
    required this.controller,
  });

  @override
  State<InputTextField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<InputTextField> {
  bool _obscureText = true;

  @override
  /// Build a [TextFormField] with a label and a password visibility toggle.
  ///
  /// If [widget.isPassword] is true, the text field will be obscured, and a
  /// toggle button will be shown to toggle the visibility of the password.
  ///
  /// The [widget.controller] is used to manage the text in the text field.
  ///
  /// The label is shown above the text field and is styled with a font size of
  /// 14 and a color of white70.
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          obscuringCharacter: '*',
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
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
        ),
      ],
    );
  }
}
