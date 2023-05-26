import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tool_track/asset_data.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'package:tool_track/screens/assets/components/assets_item.dart';

class AssetsStream extends StatelessWidget {
  AssetsStream({super.key});
  final _storageManager = StorageManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _storageManager.getAssetsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "The list is currently empty",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black38,
                    ),
                  ),
                  Text(
                    "Click '+' to add new assets",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final assets = snapshot.data?.docs;
        List<AssetsItem> assetsList = [];
        if (assets != null) {
          for (var assetData in assets) {
            assetsList.add(
              AssetsItem(
                assetData: AssetData.fromJson(assetData),
              ),
            );
          }
        }
        return ListView(
          children: assetsList,
        );
      },
    );
  }
}
