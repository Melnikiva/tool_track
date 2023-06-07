import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tool_track/constants.dart';

class SquareNetworkImage extends StatelessWidget {
  const SquareNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholderSize = 100.0,
    this.verticalSize = double.infinity,
  });

  final String imageUrl;
  final double placeholderSize;
  final double verticalSize;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CachedNetworkImage(
        imageUrl: !this.imageUrl.isEmpty ? this.imageUrl : kPlaceholderImageUrl,
        placeholder: (context, url) => Icon(
          Icons.image_outlined,
          size: this.placeholderSize,
          color: Colors.black45,
        ),
        fit: BoxFit.cover,
        height: this.verticalSize,
      ),
    );
  }
}
