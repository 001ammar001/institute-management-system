import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:institute_management_system/core/widgets/title_search_buttons_row.dart';

class TableListComponent extends StatelessWidget {
  final Size media;
  final Widget widgetPage;
  final Widget widgetButtons;
  final int buttonsNum;
  final Function function;
  final TextEditingController search;
  final Function onSubmit;
  final String label;

  const TableListComponent({
    super.key,
    required this.media,
    required this.widgetPage,
    required this.widgetButtons,
    required this.buttonsNum,
    required this.function,
    required this.search, required this.onSubmit, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(media.aspectRatio * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TitleSearchButtonsRow(
             label: label,
              onSubmit: onSubmit,
              search: search,
              function: function,
              media: media,
              buttonsNum: buttonsNum,
              buttons: widgetButtons,
            ),
          ),
          SizedBox(
            height: media.height / 60,
          ),
          Expanded(
            flex: 17,
            child: SizedBox(
              height: media.height / 1.35,
              width: media.width / 1.22,
              // color: Colors.orange,
              child: widgetPage,
            ),
          )
        ],
      ),
    );
  }
}
