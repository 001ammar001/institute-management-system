import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class CourseEntity {
  final int? id;
  final SearchEntity teacher;
  final SearchEntity subject;
  final SearchEntity room;
  final int minStudent;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final int priceToStudent;
  final int teacherSalary;
  final Set<int> days;
  final String selectedSalartType;
  final String courseStatus;

  const CourseEntity(
      {this.id,
      required this.teacher,
      required this.subject,
      required this.room,
      required this.minStudent,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.priceToStudent,
      required this.teacherSalary,
      required this.days,
      required this.selectedSalartType,
      required this.courseStatus});

  String getStatusValue() {
    switch (courseStatus) {
      case "معلق":
        return "P";
      case "منتهي" || "قيد العمل":
        return "O";
      case "ملغى":
        return "C";
      default:
        return "ERROR";
    }
  }
}
