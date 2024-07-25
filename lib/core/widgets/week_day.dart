import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';

List<String> convertNumbersToDays(List<int> daysInNumber) {
  List<String> days = [
    "الأحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت"
  ];
  List<String> returnedDays = [];
  for (int i = 0; i < days.length; i++) {
    for (int j = 0; j < daysInNumber.length; j++) {
      if (i == daysInNumber[j]) {
        returnedDays.add(days[i]);
      }
    }
  }
  return returnedDays;
}

List<Widget> convertDaystoWidgets(List<int> daysInNumber) {
  List<String> daysInString = convertNumbersToDays(daysInNumber);
  List<Widget> returnedWidgets = [];
  for (String day in daysInString) {
    returnedWidgets.add(CustomText20(text: day));
  }
  return returnedWidgets;
}

class WeekDay extends StatelessWidget {
  const WeekDay({super.key, required this.days});
  final List<int> days;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: convertDaystoWidgets(days),
    );
  }
}
