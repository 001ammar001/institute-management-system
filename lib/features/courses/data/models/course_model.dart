import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class CourseModel extends CourseEntity {
  CourseModel(
      {super.id,
      required super.teacher,
      required super.subject,
      required super.room,
      required super.minStudent,
      required super.startDate,
      required super.endDate,
      required super.startTime,
      required super.endTime,
      required super.priceToStudent,
      required super.teacherSalary,
      required super.days,
      required super.selectedSalartType,
      required super.courseStatus});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        teacher: SearchEntity.fromJson(json["teacher"]),
        subject: SearchEntity.fromJson(json["subject"]),
        room: SearchEntity.fromJson(json["room"]),
        minStudent: json["minimum_students"],
        startDate: json["start_at"],
        endDate: json["end_at"],
        startTime: json["schedule"]["starts"],
        endTime: json["schedule"]["ends"],
        priceToStudent: json["cost"],
        teacherSalary: json["salary_amount"],
        days: json["schedule"]["days"]
            .map((e) => int.parse(e))
            .toList()
            .cast<int>()
            .toSet(),
        selectedSalartType: json["salary_type"],
        courseStatus: json["status"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "subject_id": subject.id,
      "teacher_id": teacher.id,
      "room_id": room.id,
      "start_at": startDate,
      "end_at": endDate,
      "minimum_students": minStudent,
      "days": days.join(","),
      "start": startTime,
      "end": endTime,
      "status": courseStatus,
      "cost": priceToStudent,
      "salary_type": selectedSalartType,
      "salary_amount": teacherSalary,
    };
  }
}
