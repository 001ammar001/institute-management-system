import 'package:flutter/material.dart';
import 'package:institute_management_system/core/components/components.dart';
import '../buttons/back_button.dart';


class SearchAndButtons extends StatelessWidget {
  final Widget rowButtons;
  final TextEditingController controller;
  final int buttonsNum;
  final Function function;
  final Function onSubmit;
  final String label;

  const SearchAndButtons({
    super.key,
    required Size media,
    required this.rowButtons,
    required this.controller,
    required this.buttonsNum,
    required this.function,
    required this.onSubmit, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        const SizedBox(
          width: 8,
        ),
        BackButtonYellow(
          function: function,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: buttonsNum < 3 ? 6 : 4,
          child: defaultTextFiled(
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter Words'; //'Please enter Expenses Value';
              } else {
                return null;
              }
            },
            controller: controller,
            typeKeyBord: TextInputType.number,
            lableText: label,
            //'Expenses Value',
            prefix: Icons.search,
            onTap: () {},
            onSubmit: (s) {
              onSubmit();
            },
            onChanged: (s) {},
            //suffix: Icons.email,
          ),
        ),
        Spacer(flex: buttonsNum < 3 ? 8 : 2),
        Expanded(
          flex: 6,
          child: rowButtons,
        ),
      ],
    );
  }
}
