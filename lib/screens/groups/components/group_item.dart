import 'package:flutter/material.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/components/icon_description.dart';
import 'package:tool_track/components/image_card.dart';
import 'package:tool_track/components/square_network_image.dart';
import 'package:tool_track/components/tag.dart';
import 'package:tool_track/data_models/group_data.dart';
import 'package:tool_track/screens/details/details_screen.dart';

class GroupItem extends StatelessWidget {
  final GroupData groupData;
  const GroupItem({
    super.key,
    required this.groupData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4.0,
        child: InkWell(
          onTap: () {},
          child: Ink(
            padding: EdgeInsets.all(16.0),
            height: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  groupData.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconDescription(
                  icon: Icons.description_outlined,
                  text: groupData.description,
                ),
                IconDescription(
                  icon: Icons.group_outlined,
                  text: 'Users in group: ${groupData.users_count}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
