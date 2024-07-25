import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:institute_management_system/core/widgets/buttons/ckeck_close_button.dart';

class PermissionWidget extends StatelessWidget {
  final String name;
  final bool value;
  final ValueChanged<bool> valueChanged;

  const PermissionWidget({
    super.key,
    this.name = "",
    required this.value,
    required this.valueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Text("$name:")),
        CrossCheckButton(
          value: value,
          onChanged: (newValue) {
            valueChanged(newValue);
          },
        ),
      ],
    );
  }
}
