import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tool_track/components/empty_list_placeholder.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'package:tool_track/screens/assets/components/assets_item.dart';

class AssetsStream extends StatelessWidget {
  AssetsStream({super.key, required this.searchText});

  final String searchText;
  final _storageManager = StorageManager();

  List<AssetsItem> filter(List<AssetsItem> assetsList) {
    List<AssetsItem> filteredList = assetsList;
    filteredList.retainWhere(
      (element) => element.assetData.title.toLowerCase().contains(
            searchText.toLowerCase(),
          ),
    );
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _storageManager.getAssetsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return EmptyListPlaceholder();
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
        assetsList = filter(assetsList);
        assetsList.sort((a, b) => a.assetData.title.toLowerCase().compareTo(
              b.assetData.title.toLowerCase(),
            ));

        return ListView(
          padding: EdgeInsets.only(bottom: 8.0),
          children: assetsList,
        );
      },
    );
  }
}
