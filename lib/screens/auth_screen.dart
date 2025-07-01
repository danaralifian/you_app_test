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

  late UniqueKey _loginKey;
  late UniqueKey _registerKey;

  @override
  void initState() {
    super.initState();
    _loginKey = UniqueKey();
    _registerKey = UniqueKey();
  }

  void _goTo(int index) {
    setState(() {
      _currentPage = index;
      // ganti key supaya widget ter-recreate dan reset form
      if (index == 0) {
        _registerKey = UniqueKey();
      } else {
        _loginKey = UniqueKey();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: [
          RegisterFragment(key: _registerKey, onSwitch: () => _goTo(1)),
          LoginFragment(key: _loginKey, onSwitch: () => _goTo(0)),
        ],
      ),
    );
  }
}
