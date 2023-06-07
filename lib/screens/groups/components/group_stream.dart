import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tool_track/components/empty_list_placeholder.dart';
import 'package:tool_track/data_models/group_data.dart';
import 'package:tool_track/data_models/history_data.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'package:tool_track/screens/groups/components/group_item.dart';
import 'package:tool_track/screens/history/components/history_item.dart';

class GroupStream extends StatelessWidget {
  GroupStream({super.key});

  final _storageManager = StorageManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _storageManager.getGroupsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return EmptyListPlaceholder();
        }

        final groups = snapshot.data?.docs;
        List<GroupItem> groupsList = [];
        if (groups != null) {
          for (var groupData in groups) {
            groupsList.add(
              GroupItem(
                groupData: GroupData.fromJson(groupData),
              ),
            );
          }
        }
        groupsList.sort(
          (a, b) => a.groupData.title.toLowerCase().compareTo(
                b.groupData.title.toLowerCase(),
              ),
        );

        return ListView(
          padding: EdgeInsets.only(bottom: 8.0),
          children: groupsList,
        );
      },
    );
  }
}
