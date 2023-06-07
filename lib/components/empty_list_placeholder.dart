import 'package:flutter/material.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "The list is currently empty",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
