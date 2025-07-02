import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/auth/auth_controller.dart';
import 'package:you_app/modules/auth/models/auth_request.dart';
import 'package:you_app/widgets/button.dart';
import 'package:you_app/widgets/input_text_field.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateFormFilled);
    _usernameController.addListener(_updateFormFilled);
    _passwordController.addListener(_updateFormFilled);
    _confirmPasswordController.addListener(_updateFormFilled);
  }

  void _updateFormFilled() {
    setState(() {
      _isFormFilled =
          _emailController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_form.currentState?.validate() ?? false) {
      _authController.register(
        AuthRequest(
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    } else {
      debugPrint("invalid form");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
            child: const Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 25),
          InputTextField(
            hintText: 'Enter Email',
            controller: _emailController,
            borderless: true,
            size: InputSize.large,
            validator: ValidationBuilder().email().build(),
          ),
          const SizedBox(height: 20),
          InputTextField(
            hintText: 'Create Username',
            controller: _usernameController,
            borderless: true,
            size: InputSize.large,
            validator: ValidationBuilder().minLength(4).build(),
          ),
          const SizedBox(height: 20),
          InputTextField(
            hintText: 'Create Password',
            isPassword: true,
            controller: _passwordController,
            borderless: true,
            size: InputSize.large,
            validator: ValidationBuilder().minLength(6).build(),
          ),
          const SizedBox(height: 20),
          InputTextField(
            hintText: 'Confirm Password',
            isPassword: true,
            controller: _confirmPasswordController,
            borderless: true,
            size: InputSize.large,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          Obx(
            () => Button(
              text: 'Register',
              onPressed: _isFormFilled ? _register : null,
              isLoading: _authController.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
