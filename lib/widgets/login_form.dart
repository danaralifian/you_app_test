import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:you_app/modules/auth/auth_controller.dart';
import 'package:you_app/modules/auth/models/auth_request.dart';
import 'package:you_app/utils/logger.dart';
import 'package:you_app/utils/validators.dart';
import 'package:you_app/widgets/button.dart';
import 'package:you_app/widgets/input_text_field.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();
    _emailOrUsernameController.addListener(_updateFormFilled);
    _passwordController.addListener(_updateFormFilled);
  }

  void _updateFormFilled() {
    setState(() {
      _isFormFilled =
          _emailOrUsernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_form.currentState?.validate() ?? false) {
      final isEmail = isValidEmail(_emailOrUsernameController.text);
      log.i('Email or username: ${_emailOrUsernameController.text}');
      _authController.login(
        AuthRequest(
          email: isEmail ? _emailOrUsernameController.text : "",
          username: isEmail ? "" : _emailOrUsernameController.text,
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
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 25),
          InputTextField(
            hintText: 'Enter Username/Email',
            controller: _emailOrUsernameController,
            borderless: true,
            validator: ValidationBuilder().minLength(3).build(),
            size: InputSize.large,
          ),
          const SizedBox(height: 16),
          InputTextField(
            hintText: 'Enter Password',
            isPassword: true,
            controller: _passwordController,
            borderless: true,
            validator: ValidationBuilder().minLength(6).build(),
            size: InputSize.large,
          ),
          const SizedBox(height: 40),
          Obx(
            () => Button(
              text: 'Login',
              onPressed: _isFormFilled ? _login : null,
              isLoading: _authController.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
