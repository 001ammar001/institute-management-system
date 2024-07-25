import 'package:flutter/material.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/text_fields/disapled_text_field.dart';

class PairOfDisabledField extends StatelessWidget {
  const PairOfDisabledField({
    super.key,
    required this.label1,
    required this.controller1,
    required this.label2,
    required this.controller2,
    this.type = DialogTypeEnum.time,
  }) : assert(type == DialogTypeEnum.time || type == DialogTypeEnum.date);

  final String label1;
  final TextEditingController controller1;
  final String label2;
  final TextEditingController controller2;
  final DialogTypeEnum type;

  String? validateTime(String? time) {
    if (time == null || time.trim().isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (time.compareTo(controller1.text) < 0) {
      return "${type.getArabicName()} النهاية يجب ان يكون بعد ${type.getArabicName()} النهاية";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: DisabledTextField(
                    label: label1,
                    controller: controller1,
                    type: type,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: DisabledTextField(
                    label: label2,
                    controller: controller2,
                    type: type,
                    validator: type != DialogTypeEnum.list
                        ? (value) => validateTime(value)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
