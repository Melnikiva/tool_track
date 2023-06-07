import 'package:flutter/material.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/components/icon_description.dart';
import 'package:tool_track/components/image_card.dart';
import 'package:tool_track/components/square_network_image.dart';
import 'package:tool_track/components/tag.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/data_models/history_data.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'package:tool_track/screens/details/details_screen.dart';

class HistoryItem extends StatefulWidget {
  HistoryItem({
    super.key,
    required this.historyData,
  });

  final HistoryData historyData;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  AssetData assetData = AssetData();

  @override
  void initState() {
    super.initState();
    initAssetData();
  }

  void initAssetData() async {
    print(widget.historyData.asset_id);
    final jsonData =
        await StorageManager().getAssetWithId(widget.historyData.asset_id);
    setState(() {
      assetData = AssetData.fromJson(jsonData);
      print(assetData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ImageCard(
        onTap: () {
          AssetData archiveData = this.assetData;
          archiveData.timestamp = widget.historyData.timestamp;
          archiveData.coordinates = widget.historyData.coordinates;
          archiveData.tag = widget.historyData.tag;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                assetData: archiveData,
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
                text: widget.historyData.initiator,
              ),
              IconDescription(
                icon: Icons.schedule,
                text: widget.historyData.getTimeString(),
              ),
              Row(
                children: [
                  reverseTag(widget.historyData.tag),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: kPrimaryColor,
                  ),
                  Tag(status: widget.historyData.tag)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Tag reverseTag(String tag) {
    if (tag == TagStatus.available.toString()) {
      return Tag(status: TagStatus.unavailable.toString());
    }
    return Tag(status: TagStatus.available.toString());
  }
}
