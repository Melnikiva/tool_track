import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/pages.dart';

class AccountScreen extends StatelessWidget {
  static const route = 'account';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Account'),
        ),
        drawer: NavBar(initialPage: Pages.account),
      ),
    );
  }
}
