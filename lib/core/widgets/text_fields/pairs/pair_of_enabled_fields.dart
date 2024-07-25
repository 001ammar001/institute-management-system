import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';

class PairOfEnabledField extends StatelessWidget {
  const PairOfEnabledField({
    super.key,
    required this.label1,
    required this.controller1,
    required this.label2,
    required this.controller2,
    this.isRequired1 = true,
    this.isRequired2 = true,
    this.isNumeric1 = false,
    this.isNumeric2 = false,
  });

  final bool isRequired1;
  final bool isRequired2;
  final bool isNumeric1;
  final bool isNumeric2;
  final String label1;
  final TextEditingController controller1;
  final String label2;
  final TextEditingController controller2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: EnabledTextField(
              label: label1,
              controller: controller1,
              isRequired: isRequired1,
              isNumeric: isNumeric1,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: EnabledTextField(
              label: label2,
              controller: controller2,
              isRequired: isRequired2,
              isNumeric: isNumeric2,
            ),
          ),
        ],
      ),
    );
  }
}
