import 'package:flutter/material.dart';

class BackgroundHeaderTable extends StatelessWidget {
  const BackgroundHeaderTable({
    super.key,
    required this.media,
    required this.row,
  });

  final Size media;
  final Widget row;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40), topLeft: Radius.circular(40)),
          color: Colors.grey[300]),
      child: row,
    );
  }
}
