import 'package:flutter/material.dart';

class ValidationErrorMessage extends StatelessWidget {
  final FormFieldState formFieldState;
  const ValidationErrorMessage({super.key, required this.formFieldState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 10),
      child: Text(
        formFieldState.errorText!,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 13,
          color: Colors.red[700],
          height: 0.5,
        ),
      ),
    );
  }
}
