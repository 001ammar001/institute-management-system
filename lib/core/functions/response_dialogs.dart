import 'package:flutter/material.dart';

void showSucessSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Colors.green,
      showCloseIcon: true,
      content: Text(
        "تمت العملية بنجاح",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

void showErrorSnackBar(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      showCloseIcon: true,
      content: Text(
        error,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}
