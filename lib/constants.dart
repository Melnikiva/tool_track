import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF3F51B5);
const Color kSecondaryColor = Color(0xFFFF9800);
const Color kDarkPrimaryColor = Color(0xFF303F9F);

final kAppTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.light().copyWith(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
);
