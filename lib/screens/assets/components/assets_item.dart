import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tool_track/asset_data.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/screens/assets/components/tag.dart';

const String kPlaceholderImageUrl =
    'https://t4.ftcdn.net/jpg/05/07/58/41/360_F_507584110_KNIfe7d3hUAEpraq10J7MCPmtny8EH7A.jpg';

class AssetsItem extends StatelessWidget {
  final AssetData assetData;
  const AssetsItem({super.key, required this.assetData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(16.0),
          height: 150.0,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: CachedNetworkImage(
                  imageUrl: !assetData.imageUrl.isEmpty
                      ? assetData.imageUrl
                      : kPlaceholderImageUrl,
                  placeholder: (context, url) => Icon(
                    Icons.image_outlined,
                    size: 100.0,
                    color: Colors.black45,
                  ),
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
