import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_track/constants.dart';

class HistoryData {
  late String id;
  String asset_id;
  late int timestamp;
  String tag;
  String initiator;
  LatLng coordinates;

  HistoryData({
    required this.asset_id,
    required this.tag,
    required this.initiator,
    required this.coordinates,
  }) {
    this.timestamp = _getTime();
    this.id = this.timestamp.toString();
  }

  int _getTime() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() => {
        kFirestoreId: id,
        'asset_id': asset_id,
        kFirestoreTimestamp: timestamp,
        kFirestoreTag: tag,
        'initiator': initiator,
        kFirestoreCoordinates: coordinates.toJson(),
      };

  static HistoryData fromJson(QueryDocumentSnapshot parsedJson) {
    final assetObject = HistoryData(
      asset_id: parsedJson['asset_id'],
      tag: parsedJson[kFirestoreTag],
      initiator: parsedJson['initiator'],
      coordinates: parseCoordinates(parsedJson[kFirestoreCoordinates]),
    );

    assetObject.timestamp = parsedJson[kFirestoreTimestamp];
    assetObject.id = parsedJson[kFirestoreId];

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
