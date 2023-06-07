import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;

  const BorderedContainer(
      {super.key,
      required this.child,
      this.borderColor = Colors.black38,
      this.borderWidth = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(width: this.borderWidth, color: this.borderColor),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: this.child,
    );
  }
}
