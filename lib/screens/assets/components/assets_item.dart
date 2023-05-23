import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AssetsItem extends StatelessWidget {
  const AssetsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://nationaltoday.com/wp-content/uploads/2020/08/international-cat-day-1200x834.jpg',
                placeholder: (context, url) => Icon(
                  Icons.handyman,
                  size: 100.0,
                  color: Colors.black38,
                ),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Description',
                      style: TextStyle(),
                    ),
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
