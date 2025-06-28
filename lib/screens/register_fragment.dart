import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_app/utils/alert.dart';
import 'package:you_app/widgets/button.dart';
import 'package:you_app/widgets/input_text_field.dart';

class RegisterFragment extends StatefulWidget {
  final VoidCallback onSwitch;
  const RegisterFragment({super.key, required this.onSwitch});

  @override
  State<RegisterFragment> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterFragment> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
    debugPrint("test click");
    showAlert(context, 'message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(1.0, -1.2),
            radius: 1.2,
            colors: [Color(0xFF1F4247), Color(0xFF0D1D23), Color(0xFF09141A)],
            stops: [0.0, 0.56, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(child: SizedBox(height: 12)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Back',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  InputTextField(
                    hintText: 'Enter Email',
                    controller: _emailController,
                  ),
                  InputTextField(
                    hintText: 'Create Username',
                    controller: _usernameController,
                  ),
                  InputTextField(
                    hintText: 'Create Password',
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  InputTextField(
                    hintText: 'Confirm Password',
                    isPassword: true,
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(height: 40),
                  Button(
                    text: 'Register',
                    onPressed: _isFormFilled ? _register : null,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        children: [
                          const TextSpan(text: 'Have an account? '),
                          TextSpan(
                            text: 'Login here',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                widget.onSwitch();
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
