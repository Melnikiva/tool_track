import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_track/constants.dart';

class AssetData {
  String title;
  String description;
  String imageUrl;
  String creator;
  String group;
  String tag = TagState.available.toString();
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
        kFIrestoreId: id,
        kFirestoreRfid: rfid,
      };

  static AssetData fromJson(Map<String, dynamic> parsedJson) {
    return new AssetData(
      title: parsedJson[kFirestoreTitle],
    );
  }
}

enum TagState {
  available,
  unavailable,
}
