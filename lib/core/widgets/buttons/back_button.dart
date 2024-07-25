import 'package:flutter/material.dart';

class BackButtonYellow extends StatelessWidget {
  const BackButtonYellow({
    super.key,
    required this.function,
  });

  final Function function;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        //style: IconButton.styleFrom(iconSize: 50),
        onPressed: () {
          function();
        },
        padding: const EdgeInsets.only(bottom: 4.0),
        icon: const Icon(
          Icons.arrow_circle_left_rounded,
          color: Colors.yellow,
          size: 50,
          shadows: [
            Shadow(color: Colors.black87, blurRadius: 13, offset: Offset.zero)
          ],
        ));
  }
}
