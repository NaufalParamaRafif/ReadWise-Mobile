import 'package:flutter/material.dart';
import 'package:ujilevel_laravel_perpus/ui/screen/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.blue),
      ),
      home: LoginScreen(),
    );
  }
}
