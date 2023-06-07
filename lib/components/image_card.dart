import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.child,
    required this.image,
    required this.onTap,
  });

  final Widget child;
  final Function onTap;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          this.onTap();
        },
        child: Ink(
          padding: EdgeInsets.all(16.0),
          height: 150.0,
          child: Row(
            children: [
              this.image,
              SizedBox(
                width: 16.0,
              ),
              this.child,
            ],
          ),
        ),
      ),
    );
  }
}
