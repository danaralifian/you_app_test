import 'package:flutter/material.dart';
import 'package:you_app/screens/login_fragment.dart';
import 'package:you_app/screens/register_fragment.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentPage = 1; // 0 = register, 1 = login

  void _goTo(int index) {
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: [
          RegisterFragment(onSwitch: () => _goTo(1)),
          LoginFragment(onSwitch: () => _goTo(0)),
        ],
      ),
    );
  }
}
