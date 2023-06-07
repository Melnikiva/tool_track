import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_track/constants.dart';

class AssetData {
  String title;
  String description;
  String imageUrl;
  String creator;
  String group;
  String tag = TagStatus.available.toString();
  late LatLng coordinates;
  late int timestamp;
  late String id;
  late String rfid;

  AssetData({
    this.title = '',
    this.creator = '',
    this.group = '',
    this.description = '',
    this.imageUrl = '',
    this.rfid = '',
  }) {
    this.coordinates = LatLng(0, 0);
    this.timestamp = _getTime();
    this.id = this.timestamp.toString();
  }

  int _getTime() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() => {
        kFirestoreTitle: title,
        kFirestoreDescription: description,
        kFirestoreImageUrl: imageUrl,
        kFirestoreCreator: creator,
        kFirestoreTimestamp: timestamp,
        kFirestoreTag: tag,
        kFirestoreCoordinates: coordinates.toJson(),
        kFirestoreId: id,
        kFirestoreRfid: rfid,
        kFirestoreGroup: group,
      };

  static AssetData fromJson(QueryDocumentSnapshot parsedJson) {
    final assetObject = AssetData();
    assetObject.title = parsedJson[kFirestoreTitle];
    assetObject.description = parsedJson[kFirestoreDescription];
    assetObject.imageUrl = parsedJson[kFirestoreImageUrl];
    assetObject.creator = parsedJson[kFirestoreCreator];
    assetObject.timestamp = parsedJson[kFirestoreTimestamp];
    assetObject.tag = parsedJson[kFirestoreTag];
    assetObject.coordinates =
        parseCoordinates(parsedJson[kFirestoreCoordinates]);
    assetObject.id = parsedJson[kFirestoreId];
    assetObject.rfid = parsedJson[kFirestoreRfid];
    assetObject.group = parsedJson[kFirestoreGroup];

    return assetObject;
  }

  String getTimeString() {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}:${date.second}';
  }
}

LatLng parseCoordinates(List<dynamic> coordsArray) {
  return LatLng(coordsArray[0], coordsArray[1]);
}

enum TagStatus {
  available,
  unavailable,
}
