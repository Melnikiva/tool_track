import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/constants.dart';
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
          actions: [
            IconButton(
              onPressed: () {},
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

class AssetsItem extends StatelessWidget {
  const AssetsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(
                'https://nationaltoday.com/wp-content/uploads/2020/08/international-cat-day-1200x834.jpg',
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
