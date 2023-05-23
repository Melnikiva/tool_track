import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/pages.dart';
import 'package:tool_track/screens/assets/components/assets_item.dart';
import 'package:tool_track/screens/assets/create_asset_screen.dart';

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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateAssetScreen.route);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        drawer: NavBar(initialPage: Pages.assets),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            AssetsItem(),
            AssetsItem(),
            AssetsItem(),
          ],
        ),
      ),
    );
  }
}
