import 'package:flutter/material.dart';

class EnabledTextField extends StatelessWidget {
  const EnabledTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.validator,
      this.isRequired = true,
      this.isNumeric = false,
      this.obsecure = false,
      this.suffix});

  final bool obsecure;
  final Widget? suffix;
  final bool isRequired;
  final bool isNumeric;
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label:"),
        TextFormField(
          obscureText: obsecure,
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hoverColor: Colors.yellow,
            suffixIcon: suffix,
          ),
          validator: validator != null
              ? (value) => validator!(value)
              : (value) {
                  if (!isRequired && (value == null || value.isEmpty)) {
                    return null;
                  }

                  if (value == null || value.trim().isEmpty) {
                    return "هذا الحقل مطلوب";
                  }

                  if (isNumeric && int.tryParse(value) == null) {
                    return "هذا الحقل يجب ان يكون رقما";
                  }

                  return null;
                },
        ),
      ],
    );
  }
}
