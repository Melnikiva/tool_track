import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/pages.dart';

class AssetsScreen extends StatelessWidget {
  static const route = 'assets';
  AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Assets'),
        ),
        drawer: NavBar(initialPage: Pages.assets),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
