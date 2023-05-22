import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tool_track/asset_data.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/managers/account_manager.dart';

class StorageManager {
  final _accountManager = AccountManager();
  final _firestore = FirebaseFirestore.instance;

  Stream getAssetsStream() {
    return _firestore.collection(kFirestoreAssetsCollection).snapshots();
  }

  void newAsset({required AssetData assetData}) {
    _firestore.collection(kFirestoreAssetsCollection).add({
      kFirestoreTitle: assetData.title,
    });
  }
}
