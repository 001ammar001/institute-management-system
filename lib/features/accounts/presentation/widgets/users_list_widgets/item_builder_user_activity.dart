import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';

class ItemBuilderUserActivity extends StatelessWidget {
  const ItemBuilderUserActivity(
      {super.key, required this.firstText, required this.secondText});
  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color.fromARGB(255, 241, 241, 241),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        CustomText20(
          text: firstText,
        ),
        CustomText20(text: secondText)
      ]),
    );
  }
}
