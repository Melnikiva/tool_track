import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tool_track/components/empty_list_placeholder.dart';
import 'package:tool_track/data_models/history_data.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'package:tool_track/screens/history/components/history_item.dart';

class HistoryStream extends StatelessWidget {
  HistoryStream({super.key});

  final _storageManager = StorageManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _storageManager.getHistoryStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return EmptyListPlaceholder();
        }

        final history = snapshot.data?.docs;
        List<HistoryItem> historyList = [];
        if (history != null) {
          for (var historyData in history) {
            historyList.add(
              HistoryItem(
                historyData: HistoryData.fromJson(historyData),
              ),
            );
          }
        }
        historyList.sort((a, b) => b.historyData.timestamp.compareTo(
              a.historyData.timestamp,
            ));

        return ListView(
          padding: EdgeInsets.only(bottom: 8.0),
          children: historyList,
        );
      },
    );
  }
}
