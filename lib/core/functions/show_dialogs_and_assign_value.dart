import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:institute_management_system/core/functions/data_extinsions.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/features/search/presentation/page/list_seach_dialog.dart';

import '../../features/dashbord/presentation/widgets/dash_board_button.dart';

void listSearchTab(
  BuildContext context,
  SearchEntity searchEntity,
  SearchTypeEnum searchType,
  Function add,
) {
  showDialog<SearchEntity>(
    context: context,
    builder: (context) {
      return ListSearchDialogForm(
        searchType: searchType,
        add: add,
      );
    },
  ).then(
    (value) {
      if (value != null) {
        searchEntity.update(value);
      }
    },
  );
}

void dateDialogTap(BuildContext context, TextEditingController controller,
    {bool isAge = false}) {
  showDatePicker(
    context: context,
    firstDate: isAge ? DateTime(1930) : DateTime.now(),
    lastDate:
        isAge ? DateTime.now() : DateTime.now().add(const Duration(days: 365)),
  ).then((value) {
    if (value != null) {
      controller.text = value.parseTimeToString();
    }
  });
}

void timeDialogTap(BuildContext context, TextEditingController controller) {
  showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  ).then((value) {
    if (value != null) {
      controller.text = value.paraseTime();
    }
  });
}

void activityFilterTypeDialog(
  BuildContext context,
  TextEditingController controller,
) {
  showDialog(
    context: context,
    builder: (_) {
      return  Dialog(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children:generateButtons(controller)),
        ),
      ),);
    },
  );
}
List<String> names = ['دورة', 'طالب', 'أستاذ', 'موظف','غرفة','وردية','وظيفة','صنف','مادة','مادة مخزن','حساب','دور'];

List<Widget> generateButtons(TextEditingController controller) {
  List<Widget> buttons = [];
  for (String name in names) {
    buttons.add(
      const SizedBox(
        height: 20.0,
      ),
    );
    buttons.add(
      DashBoardButton(
        type: "Drawer",
        maxLines: 1,
        text: name,
        textColor: Colors.black,
        color: Colors.yellow,
        onPressed: () {
          controller.text = name;
          navigator?.pop();
        },
      ),
    );
    buttons.add(
      const SizedBox(
        height: 10.0,
      ),
    );
  }
  return buttons;
}