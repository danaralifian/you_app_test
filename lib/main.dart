import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_app/core/bindings/global_binding.dart';
import 'package:you_app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'You App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A2025),
        primaryColor: const Color(0xFF4DB6AC), // Teal accent
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C353D),
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      initialBinding: GlobalBinding(),
      initialRoute: Routes.auth,
      getPages: AppPages.routes,
    );
  }
}
