import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/pages.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const route = 'history';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History'),
        ),
        drawer: NavBar(initialPage: Pages.history),
      ),
    );
  }
}
