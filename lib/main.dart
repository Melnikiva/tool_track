import 'package:flutter/material.dart';
import 'package:tool_track/screens/account_screen.dart';
import 'package:tool_track/screens/login_screen.dart';
import 'package:tool_track/screens/assets_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/assets': (context) => AssetsScreen(),
        '/account': (context) => AccountScreen(),
      },
    );
  }
}
