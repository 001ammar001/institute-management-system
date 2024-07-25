import 'package:flutter/material.dart';

class IconsRowOptions extends StatelessWidget {
  const IconsRowOptions({
    super.key,
    required this.item,
    required this.delete,
    required this.edit,
    this.checkBox,
    this.deleteIcon = Icons.delete,
    this.deleteIconColor = Colors.red,
  });

  final dynamic item;
  final Function delete;
  final Function edit;
  final Function? checkBox;
  final IconData deleteIcon;
  final Color deleteIconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Checkbox(
            checkColor: Colors.black87,
            activeColor: Colors.yellow,
            value: item.runtimeType == bool ? item : item?.index,
            onChanged: (newValue) {
              checkBox!(newValue!);
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              edit();
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(deleteIcon, color: deleteIconColor),
            onPressed: () {
              delete();
            },
          ),
        ),
      ],
    );
  }
}
