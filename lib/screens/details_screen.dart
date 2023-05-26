import 'package:flutter/material.dart';
import 'package:tool_track/asset_data.dart';

class DetailsScreen extends StatelessWidget {
  static const String route = 'details';

  const DetailsScreen({
    super.key,
    required this.assetData,
  });
  final AssetData assetData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          assetData.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(child: Text('${assetData.toJson()}')),
    );
  }
}
