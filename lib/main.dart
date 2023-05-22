import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/screens/account_screen.dart';
import 'package:tool_track/screens/info/info_screen.dart';
import 'package:tool_track/screens/login_screen.dart';
import 'package:tool_track/screens/assets_screen.dart';
import 'package:tool_track/screens/registration_screen.dart';
import 'package:tool_track/screens/settings_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light().copyWith(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
        ),
      ),
      initialRoute: LoginScreen.route,
      routes: {
        RegistrationScreen.route: (context) => RegistrationScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        AssetsScreen.route: (context) => AssetsScreen(),
        AccountScreen.route: (context) => AccountScreen(),
        SettingsScreen.route: (context) => SettingsScreen(),
        InfoScreen.route: (context) => InfoScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
