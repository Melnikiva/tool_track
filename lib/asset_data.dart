import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_track/constants.dart';

class AssetData {
  String title;
  String description;
  String imageUrl;
  String creator;
  String group;
  String tag = TagState.available.toString();
  LatLng? coordinates;
  late int timestamp;
  late int id;

  AssetData({
    this.title = '',
    this.creator = '',
    this.group = '',
    this.description = '',
    this.imageUrl = '',
    this.coordinates,
  }) {
    this.timestamp = _getTime();
    this.id = this.timestamp;
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
        kFirestoreCoordinates: coordinates?.toJson(),
        kFIrestoreId: id,
      };
}

enum TagState {
  available,
  unavailable,
}
