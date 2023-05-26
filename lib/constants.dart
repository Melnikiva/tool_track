import 'package:flutter/material.dart';

// Text Style
const TextStyle kTextStyleDefault = TextStyle(fontSize: 16.0);

// Icons
const IconData kMainIcon = Icons.handyman_rounded;

// Gaps
const double kFormElemetsGap = 16.0;

// Colors
const Color kPrimaryColor = Color(0xFF3F51B5);
const Color kSecondaryColor = Color(0xFFFF9800);
const Color kPrimaryLightColor = Color(0xFFC5CAE9);
const Color kPrimaryDarkColor = Color(0xFF303F9F);
const Color kAlertColor = Colors.red;

// Regural Expressions to validate input
final RegExp kEmailValidation = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

// Firebase

const String kFirestoreAssetsCollection = 'assets';
const String kFirestoreHistoryCollection = 'history';
const String kFirestoreImageUrl = 'image_url';
const String kFirestoreTitle = 'title';
const String kFirestoreDescription = 'description';
const String kFirestoreCreator = 'creator';
const String kFirestoreGroup = 'group';
const String kFirestoreTimestamp = 'timestamp';
const String kFirestoreTag = 'tag';
const String kFirestoreCoordinates = 'coordinates';
const String kFIrestoreId = 'id';
const String kFirestoreRfid = 'rfid';

// Warnings
const String kNfcUnavailable = 'Error getting RFID data';
