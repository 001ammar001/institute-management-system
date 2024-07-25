import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:institute_management_system/core/widgets/table_screen/search_buttons_row.dart';
import '../Them/custom_colors.dart';

class TitleSearchButtonsRow extends StatelessWidget {
  const TitleSearchButtonsRow({
    super.key,
    required this.media,
    required this.buttons,
    required this.buttonsNum, required this.function, required this.search, required this.onSubmit, required this.label,
  });

  final Size media;
  final Widget buttons;
  final int buttonsNum;
  final Function function;
  final TextEditingController search;
  final Function onSubmit;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              color: gray150,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SearchAndButtons(
                onSubmit: onSubmit,
                function: function,
                buttonsNum: buttonsNum,
                media: media,
                rowButtons: buttons,
                controller: search,
                label: label,
              ),
            ),
          ),
        )
      ],
    );
  }
}
