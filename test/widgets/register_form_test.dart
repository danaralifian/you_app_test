import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:you_app/modules/auth/auth_controller.dart';
import 'package:you_app/modules/auth/models/auth_request.dart';
import 'package:you_app/widgets/register_form.dart'; // ganti path jika perlu

class MockAuthController extends AuthController {
  bool didCallRegister = false;
  late AuthRequest submittedRequest;

  @override
  Future<void> register(AuthRequest request) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 100));
    didCallRegister = true;
    submittedRequest = request;
    isLoading.value = false;
  }
}

void main() {
  late MockAuthController mockController;

  setUp(() {
    Get.put<Dio>(Dio());
    mockController = MockAuthController();
    Get.put<AuthController>(mockController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('RegisterFormWidget works and calls register', (
    WidgetTester tester,
  ) async {
    debugPrint('Running test: RegisterFormWidget works and calls register');
    await tester.pumpWidget(
      const GetMaterialApp(home: Scaffold(body: RegisterFormWidget())),
    );

    final emailField = find.byType(TextFormField).at(0);
    final usernameField = find.byType(TextFormField).at(1);
    final passwordField = find.byType(TextFormField).at(2);
    final confirmPasswordField = find.byType(TextFormField).at(3);
    final registerButton = find.widgetWithText(ElevatedButton, 'Register');

    // Fill all fields
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'password123');
    await tester.enterText(confirmPasswordField, 'password123');
    await tester.pump();
    await tester.pumpAndSettle(); // ensure rebuild done

    // Tap register
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Expect register was called
    expect(mockController.didCallRegister, isTrue);
    expect(mockController.submittedRequest.email, equals('test@example.com'));
    expect(mockController.submittedRequest.username, equals('testuser'));
    expect(mockController.submittedRequest.password, equals('password123'));
  });

  testWidgets('Shows validation error when passwords do not match', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const GetMaterialApp(home: Scaffold(body: RegisterFormWidget())),
    );

    final emailField = find.byType(TextFormField).at(0);
    final usernameField = find.byType(TextFormField).at(1);
    final passwordField = find.byType(TextFormField).at(2);
    final confirmPasswordField = find.byType(TextFormField).at(3);
    final registerButton = find.widgetWithText(ElevatedButton, 'Register');

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'password123');
    await tester.enterText(confirmPasswordField, 'differentPassword');
    await tester.pump();
    await tester.pumpAndSettle(); // ensure rebuild done

    // Tap register
    await tester.tap(registerButton);
    await tester.pump(); // enough to show validation

    expect(find.text('Passwords do not match'), findsOneWidget);
  });
}
