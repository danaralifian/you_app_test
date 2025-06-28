import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:you_app/utils/alert.dart';
import 'package:you_app/widgets/button.dart';
import 'package:you_app/widgets/input_text_field.dart';

class LoginFragment extends StatefulWidget {
  final VoidCallback onSwitch;
  const LoginFragment({super.key, required this.onSwitch});

  @override
  State<LoginFragment> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginFragment> {
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  InputTextField(
                    hintText: 'Enter Username/Email',
                    controller: _emailOrUsernameController,
                    borderless: true,
                  ),
                  const SizedBox(height: 16),
                  InputTextField(
                    hintText: 'Enter Password',
                    isPassword: true,
                    controller: _passwordController,
                    borderless: true,
                  ),
                  const SizedBox(height: 40),
                  Button(
                    text: 'Login',
                    onPressed: _isFormFilled ? _login : null,
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
                          const TextSpan(text: 'No account? '),
                          TextSpan(
                            text: 'Register here',
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
