import 'package:flutter/material.dart';

class TableListButtonsAppBar extends StatelessWidget {
  const TableListButtonsAppBar({
    super.key,
    required this.function,
    required this.text,
  });

  final Function function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: MaterialButton(
            height: 75,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.yellow,
            onPressed: () {
              function();
            },
            child: Text(
              text,
              style: const TextStyle(color: Colors.black87, fontSize: 15),
            )));
  }
}
