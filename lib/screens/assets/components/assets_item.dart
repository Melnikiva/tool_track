import 'package:flutter/material.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/components/icon_description.dart';
import 'package:tool_track/components/image_card.dart';
import 'package:tool_track/components/square_network_image.dart';
import 'package:tool_track/components/tag.dart';
import 'package:tool_track/screens/details/details_screen.dart';

class AssetsItem extends StatelessWidget {
  final AssetData assetData;
  const AssetsItem({
    super.key,
    required this.assetData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ImageCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                assetData: this.assetData,
              ),
            ),
          );
        },
        image: SquareNetworkImage(imageUrl: assetData.imageUrl),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                assetData.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconDescription(
                icon: Icons.person_outline,
                text: assetData.creator,
              ),
              IconDescription(
                icon: Icons.group_outlined,
                text: assetData.group.isEmpty
                    ? 'Personal group'
                    : assetData.group,
              ),
              Tag(status: assetData.tag)
            ],
          ),
        ),
      ),
    );
  }
}
