import 'package:flutter/material.dart';

class CardIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const CardIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      borderRadius: BorderRadius.circular(6.0),
      child: IconButton(
        onPressed: () {
          this.onPressed();
        },
        iconSize: 30.0,
        icon: Icon(
          this.icon,
          color: Colors.black54,
        ),
      ),
    );
  }
}
