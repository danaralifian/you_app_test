import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:you_app/modules/auth/auth_controller.dart';
import 'package:you_app/modules/auth/models/auth_reponse.dart';
import 'package:you_app/modules/auth/models/auth_request.dart';
import 'package:you_app/widgets/login_form.dart';

class MockAuthController extends AuthController {
  @override
  Future<void> login(AuthRequest request) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 100));
    user.value = AuthResponse(
      message: 'Login successful',
      accessToken: 'mock-token',
    );
    isLoading.value = false;
  }

  @override
  Future<void> register(AuthRequest request) async {
    // not needed in this test
  }
}

void main() {
  setUp(() {
    // Register mock Dio (if needed somewhere)
    Get.put<Dio>(Dio());

    // Inject MockAuthController
    Get.put<AuthController>(MockAuthController());
  });

  tearDown(() {
    Get.reset(); // clear all registered instances after each test
  });

  testWidgets('LoginFormWidget renders and works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(home: Scaffold(body: LoginFormWidget())),
    );

    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    final loginButton = find.widgetWithText(ElevatedButton, 'Login');

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Fill form
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.pump();

    // Tap login
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Expect mock login result
    final controller = Get.find<AuthController>();
    expect(controller.user.value?.accessToken, equals('mock-token'));
  });
}
