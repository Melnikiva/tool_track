import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tool_track/constants.dart';

class GroupData {
  int id;
  String title;
  String description;
  int users_count;
  String password;

  GroupData({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.users_count = 1,
    this.password = '',
  }) {}

  Map<String, dynamic> toJson() => {
        kFirestoreId: id,
        kFirestoreTitle: title,
        kFirestoreDescription: description,
        'password': password, // TODO
        'user_count': users_count
      };

  static GroupData fromJson(QueryDocumentSnapshot parsedJson) {
    final groupObject = GroupData();

    groupObject.id = parsedJson[kFirestoreId];
    groupObject.description = parsedJson[kFirestoreDescription];
    groupObject.title = parsedJson[kFirestoreTitle];
    groupObject.password = parsedJson['password'];
    groupObject.users_count = parsedJson['user_count'];
    return groupObject;
  }
}
