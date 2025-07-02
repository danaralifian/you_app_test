import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:mocktail/mocktail.dart';

import 'package:you_app/modules/auth/auth_service.dart';
import 'package:you_app/modules/auth/models/auth_request.dart';
import 'package:you_app/modules/auth/models/auth_reponse.dart';

class MockDio extends Mock implements dio.Dio {}

void main() {
  late MockDio mockDio;
  late AuthService authService;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockDio = MockDio();
    Get.put<dio.Dio>(mockDio); // Register mock Dio ke GetX
    authService = AuthService();
  });

  tearDown(() {
    Get.reset();
  });

  test('login returns AuthResponse when Dio responds successfully', () async {
    final request = AuthRequest(
      email: 'test@example.com',
      username: '',
      password: 'secret',
    );

    final fakeResponse = dio.Response(
      requestOptions: dio.RequestOptions(path: '/login'),
      statusCode: 200,
      data: {'message': 'Login successful', 'access_token': 'mock-token'},
    );

    when(
      () => mockDio.post('/login', data: any(named: 'data')),
    ).thenAnswer((_) async => fakeResponse);

    final result = await authService.login(request);

    expect(result, isA<AuthResponse>());
    expect(result.message, 'Login successful');
    expect(result.accessToken, 'mock-token');
  });

  test(
    'register calls /register then login and returns AuthResponse',
    () async {
      final request = AuthRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'secret',
      );

      // Step 1: mock /register
      when(
        () => mockDio.post(
          '/register',
          data: {
            'email': request.email,
            'username': request.username,
            'password': request.password,
          },
        ),
      ).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(path: '/register'),
          statusCode: 201,
          data: {'message': 'Created'},
        ),
      );

      // Step 2: mock /login
      when(
        () => mockDio.post(
          '/login',
          data: {
            'email': request.email,
            'username': request.username,
            'password': request.password,
          },
        ),
      ).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(path: '/login'),
          statusCode: 200,
          data: {'message': 'Login successful', 'access_token': 'mock-token'},
        ),
      );

      final result = await authService.register(request);

      expect(result, isA<AuthResponse>());
      expect(result.message, 'Login successful');
      expect(result.accessToken, 'mock-token');

      verify(
        () => mockDio.post('/register', data: any(named: 'data')),
      ).called(1);
      verify(() => mockDio.post('/login', data: any(named: 'data'))).called(1);
    },
  );
}
