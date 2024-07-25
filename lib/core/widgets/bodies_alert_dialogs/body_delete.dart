import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/buttons/yes_no_button.dart';

void alertDialogGeneral({
  required BuildContext context,
  required String title,
  required Function submitFunction,
  int mediaHeight = 4,
  int mediaWidth = 3,
}) {
  final AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    contentPadding: const EdgeInsets.all(20.0),
    content: SizedBox(
        height: MediaQuery.of(context).size.width / mediaHeight,
        width: MediaQuery.of(context).size.width / mediaWidth,
        child: alertDialogBody(
            context: context, submitFunction: submitFunction, title: title)),
  );
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return alert;
      });
}

Widget alertDialogBody({
  required BuildContext context,
  required Function submitFunction,
  required String title,
}) {
  return Container(
    color: Colors.grey.shade200,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      // crossAxisAlignment: CrossAxisAlignment.,
      children: [
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              YesNoButton(
                yes: true,
                onYesSubmited: () {
                  submitFunction();
                },
              ),
              const YesNoButton(yes: false)
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}
