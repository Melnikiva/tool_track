import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/pages.dart';

final kGrayColor = Colors.black.withOpacity(0.65);

class InfoScreen extends StatelessWidget {
  static const route = 'info';
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Info'),
        ),
        drawer: NavBar(initialPage: Pages.info),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 48.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(kMainIcon, size: 100.0, color: kGrayColor),
                SizedBox(height: 16.0),
                Text(
                  'Tool Track',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: kGrayColor,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ivan Melnyk',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: kGrayColor,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '2023',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: kGrayColor,
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  'ivanmel.vn23@gmail.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: kGrayColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
