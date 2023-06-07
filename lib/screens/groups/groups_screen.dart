import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/components/rect_button.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/pages.dart';
import 'package:tool_track/screens/groups/components/group_stream.dart';

class GroupsScreen extends StatelessWidget {
  static const route = 'groups';
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Groups',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: NavBar(initialPage: Pages.groups),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: GroupStream(),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: 16.0,
              top: 8.0,
              left: 16.0,
              right: 16.0,
            ),
            child: RectButton(
              text: 'JOIN GROUP',
              onPressed: () {},
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
