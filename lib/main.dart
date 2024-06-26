import 'package:data_karyawan/pages/home_page.dart';
import 'package:data_karyawan/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Karyawan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2196F3)),
        useMaterial3: true,
      ),
      home: const SplashScreenPage(),
    );
  }
}
