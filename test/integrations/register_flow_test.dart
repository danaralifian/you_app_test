import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:mocktail/mocktail.dart';

import 'package:you_app/widgets/register_form.dart';
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
    'RegisterFormWidget performs register and navigates on success',
    (tester) async {
      debugPrint(
        'Running test: RegisterFormWidget performs register and navigates on success',
      );

      await tester.runAsync(() async {
        final navigatorObserver = _TestNavigatorObserver();

        when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => dio.Response(
            requestOptions: dio.RequestOptions(path: '/register'),
            statusCode: 200,
            data: {'access_token': 'mock-token'},
          ),
        );

        await tester.pumpWidget(
          GetMaterialApp(
            navigatorObservers: [navigatorObserver],
            initialRoute: '/',
            getPages: [
              GetPage(
                name: '/',
                page: () => const Scaffold(body: RegisterFormWidget()),
              ),
              GetPage(
                name: Routes.profile,
                page: () => Scaffold(body: Center(child: Text('Profile Page'))),
              ),
            ],
          ),
        );

        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextFormField).at(0),
          'test@example.com',
        );
        await tester.enterText(find.byType(TextFormField).at(1), 'tester');
        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.enterText(find.byType(TextFormField).at(3), 'password123');
        await tester.pumpAndSettle();

        final registerButton = find.widgetWithText(ElevatedButton, 'Register');
        await tester.tap(registerButton);
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        debugPrint('Navigated to route: ${navigatorObserver.navigatedTo}');

        expect(
          navigatorObserver.navigatedTo,
          Routes.profile,
          reason: 'Should navigate to profile after register success',
        );

        expect(find.text('Success'), findsOneWidget);
        expect(find.text('Registered successfully'), findsOneWidget);

        verify(() => mockDio.post(any(), data: any(named: 'data'))).called(2);
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
