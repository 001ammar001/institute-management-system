import 'package:flutter/material.dart';
import 'package:institute_management_system/core/functions/show_dialogs_and_assign_value.dart';
import 'package:institute_management_system/core/utils/enums.dart';

class DisabledTextField extends StatelessWidget {
  const DisabledTextField({
    super.key,
    this.type = DialogTypeEnum.time,
    required this.controller,
    required this.label,
    this.validator,
  }) : assert((type != DialogTypeEnum.list));

  final TextEditingController controller;
  final String label;
  final DialogTypeEnum type;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label:"),
        GestureDetector(
          onTap: () {
            switch (type) {
              case DialogTypeEnum.time:
                timeDialogTap(context, controller);
                break;
              case DialogTypeEnum.activityFilterType:
                activityFilterTypeDialog(context, controller);
                break;
              default:
                dateDialogTap(
                  context,
                  controller,
                  isAge: type == DialogTypeEnum.age,
                );
            }
          },
          child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
              )),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            validator: (value) {
              if (validator != null) {
                return validator!(value);
              } else if (value == null || value.trim().isEmpty) {
                return "هذا الحقل مطلوب";
              }
              return null;
            },
            enabled: false,
          ),
        ),
      ],
    );
  }
}
