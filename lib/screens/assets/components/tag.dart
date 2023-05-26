import 'package:flutter/material.dart';
import 'package:tool_track/asset_data.dart';

class Tag extends StatelessWidget {
  final TagStatus status;
  const Tag({
    super.key,
    required this.status,
  });

  Widget buildTagWithStatus(status) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return buildTagWithStatus(status);
  }
}
