import 'package:flutter/material.dart';

extension DateParasing on DateTime {
  String parseTimeToString() {
    return "$year-${month.toString().padLeft(2, "0")}-${day.toString().padLeft(2, "0")}";
  }

  String parseDateTimeToTime() {
    return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}";
  }
}

extension TimeParasing on TimeOfDay {
  String paraseTime() {
    return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}";
  }
}

extension ParaseTimeToEventDate on String {
  DateTime paraseStringToEvent() {
    final DateTime now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(split(":")[0]),
      int.parse(split(":")[1]),
    );
  }
}
