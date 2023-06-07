import 'package:flutter/material.dart';
import 'package:tool_track/constants.dart';

class IconDescription extends StatelessWidget {
  const IconDescription({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.0,
          color: kPrimaryColor,
        ),
        SizedBox(width: 4.0),
        Text(
          text,
          style: TextStyle(),
        ),
      ],
    );
  }
}
