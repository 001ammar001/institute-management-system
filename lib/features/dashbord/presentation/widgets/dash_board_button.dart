import 'package:flutter/material.dart';

class DashBoardButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final Color textColor;
  final int maxLines;
  final String type;

  const DashBoardButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.yellow,
    this.maxLines = 3,
    this.textColor = Colors.black,
    this.type = "DashBoard",
  });

  @override
  Widget build(BuildContext context) {
    return type=='DashBoard'?Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: MaterialButton(
            height: 75,
            minWidth: 170,
            elevation: 2.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: color,
            onPressed: () {
              onPressed();
            },
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: maxLines,
              style: TextStyle(
                color: textColor,
                overflow: TextOverflow.ellipsis,
              ),
            )),
      ),
    ):Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MaterialButton(
          height: 65,
          minWidth: 170,
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: color,
          onPressed: () {
            onPressed();
          },
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: maxLines,
            style: TextStyle(
              color: textColor,
              overflow: TextOverflow.ellipsis,
            ),
          )),
    );
  }
}
