import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/pages.dart';

class SettingsScreen extends StatelessWidget {
  static const route = 'settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        drawer: NavBar(initialPage: Pages.settings),
      ),
    );
  }
}
