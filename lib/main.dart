import 'package:flutter/material.dart';
import 'package:tool_track/screens/account_screen.dart';
import 'package:tool_track/screens/info_screen.dart';
import 'package:tool_track/screens/login_screen.dart';
import 'package:tool_track/screens/assets_screen.dart';
import 'package:tool_track/screens/settings_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        AssetsScreen.route: (context) => AssetsScreen(),
        AccountScreen.route: (context) => AccountScreen(),
        SettingsScreen.route: (context) => SettingsScreen(),
        InfoScreen.route: (context) => InfoScreen(),
      },
    );
  }
}
