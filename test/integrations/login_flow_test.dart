import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:mocktail/mocktail.dart';

import 'package:you_app/widgets/login_form.dart';
import 'package:you_app/modules/auth/auth_controller.dart';
import 'package:you_app/routes/app_pages.dart';

class MockDio extends Mock implements dio.Dio {}

class FakeRequestOptions extends dio.RequestOptions {
  FakeRequestOptions() : super(path: '');
}

void main() {
  late MockDio mockDio;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDio = MockDio();
    Get.testMode = true;
    Get.put<dio.Dio>(mockDio);
    Get.put(AuthController());
  });

  tearDown(() {
    Get.closeAllSnackbars();
    Get.reset();
  });

  testWidgets(
    'LoginFormWidget performs login and navigates on success',
    (tester) async {
      debugPrint(
        'Running test: LoginFormWidget performs login and navigates on success',
      );
      await tester.runAsync(() async {
        final navigatorObserver = _TestNavigatorObserver();

        when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => dio.Response(
            requestOptions: dio.RequestOptions(path: '/login'),
            statusCode: 200,
            data: {'message': 'Login successful', 'access_token': 'mock-token'},
          ),
        );

        await tester.pumpWidget(
          GetMaterialApp(
            navigatorObservers: [navigatorObserver],
            initialRoute: '/',
            getPages: [
              GetPage(
                name: '/',
                page: () => Scaffold(body: LoginFormWidget()),
              ),
              GetPage(
                name: Routes.profile,
                page: () => Scaffold(body: Center(child: Text('Profile Page'))),
              ),
            ],
          ),
        );

        final emailField = find.byType(TextFormField).first;
        final passwordField = find.byType(TextFormField).last;
        final loginButton = find.widgetWithText(ElevatedButton, 'Login');

        await tester.enterText(emailField, 'test@example.com');
        await tester.enterText(passwordField, 'password123');
        await tester.pumpAndSettle();

        await tester.tap(loginButton);
        await tester.pump();

        // Tunggu snackbar durasi 3 detik muncul dan animasi selesai
        await tester.pump(const Duration(seconds: 3));
        await tester.pumpAndSettle();

        debugPrint('Navigated to route: ${navigatorObserver.navigatedTo}');

        expect(
          navigatorObserver.navigatedTo,
          Routes.profile,
          reason: 'Should navigate to profile after login success',
        );

        expect(find.text('Success'), findsOneWidget);
        expect(find.text('Logged in successfully'), findsOneWidget);

        verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);
      });
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
}

class _TestNavigatorObserver extends NavigatorObserver {
  String? navigatedTo;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      navigatedTo = route.settings.name;
    }
    super.didPush(route, previousRoute);
  }
}
