import 'package:flutter/material.dart';

// Icons
const IconData kMainIcon = Icons.handyman_rounded;

// Gaps
const double kFormElemetsGap = 16.0;

// Colors
const Color kPrimaryColor = Color(0xFF3F51B5);
const Color kSecondaryColor = Color(0xFFFF9800);
const Color kPrimaryDarkColor = Color(0xFF303F9F);

// Regural Expressions to validate input
final RegExp kEmailValidation = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

// Firebase

const String kFirestoreUsersCollection = 'users';
const String kFirestoreEmail = 'email';
const String kFirestoreFullName = 'fullname';
