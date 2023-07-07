import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/data_models/group_data.dart';
import 'package:tool_track/data_models/history_data.dart';
import 'package:tool_track/managers/account_manager.dart';
import 'package:tool_track/managers/location_manager.dart';

class StorageManager {
  final _firestore = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();

  Stream<QuerySnapshot> getAssetsStream() {
    return _firestore.collection(kFirestoreAssetsCollection).snapshots();
  }

  Stream<QuerySnapshot> getHistoryStream() {
    return _firestore.collection(kFirestoreHistoryCollection).snapshots();
  }

  Stream<QuerySnapshot> getGroupsStream() {
    return _firestore.collection(kFirestoreGroupsCollection).snapshots();
  }

  Future<List> getGroups() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(kFirestoreGroupsCollection).get();
    final List groups = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<String> groupTitles =
        groups.map((group) => group['title'] as String).toList();
    groupTitles.add('');
    return groupTitles;
  }

  Future newAsset({required AssetData assetData}) async {
    return await _firestore
        .collection(kFirestoreAssetsCollection)
        .add(assetData.toJson());
  }

  Future newHistoryRecord({required HistoryData historyData}) async {
    return await _firestore
        .collection(kFirestoreHistoryCollection)
        .add(historyData.toJson());
  }

  Future newGroup({required GroupData groupData}) async {
    return await _firestore
        .collection(kFirestoreGroupsCollection)
        .add(groupData.toJson());
  }

  Future removeGroup(String title) async {
    try {
      final post = await _firestore
          .collection(kFirestoreGroupsCollection)
          .where('title', isEqualTo: title)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        return snapshot.docs[0].reference;
      });

      var batch = _firestore.batch();
      batch.delete(post);
      batch.commit();
    } catch (e) {
      print(e);
    }
  }

  Future removeAsset(String id) async {
    try {
      final post = await _firestore
          .collection(kFirestoreAssetsCollection)
          .where('id', isEqualTo: id)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        return snapshot.docs[0].reference;
      });

      var batch = _firestore.batch();
      batch.delete(
        post,
      );
      batch.commit();
    } catch (e) {
      print(e);
    }
  }

  void createHistoryRecord(String rfid) async {
    var assetJson = await getAssetWithRfid(rfid);
    print(rfid);
    if (assetJson == null) {
      return;
    }
    AssetData assetData = AssetData.fromJson(assetJson);
    Position pos = await LocationManager().getCurrentPosition();
    LatLng coordinates = LatLng(pos.latitude, pos.longitude);

    assetData.coordinates = coordinates;
    assetData.tag = reverseTag(assetData.tag);

    HistoryData newHistoryData = HistoryData(
      asset_id: assetData.id,
      tag: assetData.tag,
      initiator: AccountManager().getFullName(),
      coordinates: assetData.coordinates,
    );

    newHistoryRecord(historyData: newHistoryData);
    updateAsset(assetData);
  }

  void updateAsset(AssetData newData) async {
    try {
      final post = await _firestore
          .collection(kFirestoreAssetsCollection)
          .where('id', isEqualTo: newData.id)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        return snapshot.docs[0].reference;
      });

      var batch = _firestore.batch();
      batch.update(
        post,
        newData.toJson(),
      );
      batch.commit();
    } catch (e) {
      print(e);
    }
  }

  Future getAssetWithId(String id) async {
    var asset;
    await _firestore
        .collection(kFirestoreAssetsCollection)
        .where('id', isEqualTo: id)
        .get()
        .then(
      (querySnapshot) {
        asset = querySnapshot.docs.first;
      },
    );
    return asset;
  }

  Future getAssetWithRfid(String rfid) async {
    var asset = null;
    try {
      await _firestore
          .collection(kFirestoreAssetsCollection)
          .where('rfid', isEqualTo: rfid)
          .get()
          .then(
        (querySnapshot) {
          asset = querySnapshot.docs.first;
        },
      );
    } catch (e) {
      print('RFID not found');
    }
    return asset;
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

String reverseTag(String tag) {
  return tag == TagStatus.available.toString()
      ? TagStatus.unavailable.toString()
      : TagStatus.available.toString();
}
