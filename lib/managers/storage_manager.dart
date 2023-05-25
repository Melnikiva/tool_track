import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tool_track/asset_data.dart';
import 'package:tool_track/constants.dart';

class StorageManager {
  final _firestore = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();

  Stream getAssetsStream() {
    return _firestore.collection(kFirestoreAssetsCollection).snapshots();
  }

  void newAsset({required AssetData assetData}) async {
    await _firestore
        .collection(kFirestoreAssetsCollection)
        .add(assetData.toJson());
  }

  Future? uploadImage(XFile? image) async {
    if (image == null) return null;
    Reference imagesDirRef = _storageRef.child('images');
    Reference uploadedImageRef = imagesDirRef.child(_getUniqueFileName());
    try {
      await uploadedImageRef.putFile(File(image.path));
      return uploadedImageRef.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return null;
  }

  String _getUniqueFileName() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
