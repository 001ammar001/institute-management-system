import 'package:flutter/material.dart';

class BackgroundButtonsPages extends StatelessWidget {
  const BackgroundButtonsPages({
    super.key,
    required this.buttonsRow,
  });
  final Widget buttonsRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      ),
      child: buttonsRow,
    );
  }
}
