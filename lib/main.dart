import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const DentalApp());
}

class DentalApp extends StatelessWidget {
  const DentalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica Dental',
      theme: ThemeData(
        primaryColor: const Color(0xFF0d6efd),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF0d6efd),
          secondary: const Color(0xFF00b4d8),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0d6efd),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0d6efd),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
