import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'package:tool_track/pages.dart';
import 'package:tool_track/screens/assets/components/assets_item.dart';
import 'package:tool_track/screens/assets/components/assets_stream.dart';
import 'package:tool_track/screens/assets/create_asset_screen.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});
  static const route = 'assets';

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  final StorageManager _storageManager = StorageManager();
  late Stream assetsStream;

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
        body: AssetsStream(),
      ),
    );
  }
}
