import 'package:flutter/material.dart';
import 'package:tool_track/components/navbar.dart';
import 'package:tool_track/components/rect_button.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/data_models/group_data.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'package:tool_track/pages.dart';
import 'package:tool_track/screens/groups/components/group_stream.dart';

class GroupsScreen extends StatefulWidget {
  static const route = 'groups';
  GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  GroupData newGroupData = GroupData();

  void showCreateGroupDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create group'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLength: 30,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title",
              ),
              onChanged: (value) {
                newGroupData.title = value;
              },
            ),
            SizedBox(height: kFormElemetsGap / 2),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Description",
              ),
              onChanged: (value) {
                newGroupData.description = value;
              },
            ),
            SizedBox(height: kFormElemetsGap),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
              onChanged: (value) {
                newGroupData.password = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (!newGroupData.title.isEmpty) {
                StorageManager().newGroup(groupData: newGroupData);
                newGroupData = GroupData();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Groups',
        ),
        actions: [
          IconButton(
            onPressed: () {
              showCreateGroupDialog(context);
            },
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
