import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';

class BuilderItemTeacherCourses extends StatelessWidget {
  const BuilderItemTeacherCourses(
      {super.key, required this.firstText, required this.secondText});
  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        CustomText20(
          text: firstText,
        ),
        CustomText20(text: secondText)
      ]),
    );
  }
}
