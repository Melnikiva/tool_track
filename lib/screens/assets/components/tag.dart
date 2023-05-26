import 'package:flutter/material.dart';
import 'package:tool_track/asset_data.dart';

class Tag extends StatelessWidget {
  final String status;
  const Tag({
    super.key,
    required this.status,
  });

  bool isAvailable() {
    if (status == TagStatus.available.toString()) return true;
    return false;
  }

  Widget buildTagWithStatus(status) {
    return Material(
      color: isAvailable() ? Colors.green.shade300 : Colors.red.shade300,
      borderRadius: BorderRadius.circular(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          isAvailable() ? 'Available' : 'Unavailable',
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTagWithStatus(status);
  }
}
