import 'package:flutter/material.dart';
import 'package:tool_track/constants.dart';

class RectButton extends StatelessWidget {
  const RectButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = kPrimaryColor,
  });
  final Function onPressed;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => this.onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(this.text),
      ),
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll<TextStyle>(
          TextStyle(fontSize: 18.0),
        ),
        backgroundColor: MaterialStatePropertyAll<Color>(this.color),
      ),
    );
  }
}
