import 'package:flutter/material.dart';

class YesNoButton extends StatelessWidget {
  final bool yes;
  final Function()? onYesSubmited;
  const YesNoButton({super.key, required this.yes, this.onYesSubmited})
      : assert((yes && onYesSubmited != null) || !yes);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 65,
        minWidth: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: yes ? Colors.red : Colors.blue,
        onPressed: () {
          if (yes) {
            onYesSubmited!();
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Text(
          yes ? "نعم" : "لا",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));
  }
}
