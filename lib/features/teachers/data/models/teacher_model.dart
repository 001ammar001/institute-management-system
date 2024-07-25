import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';

class TeacherModel extends TeacherEntity {
  TeacherModel(
      {super.id,
      required super.name,
      required super.phoneNumber,
      required super.birthDate,
      required super.credentials,
      super.teacherCourse});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    List<TeacherCourse> courses = [];
    for (int i = 0; i < json["recent_courses"].length; i++) {
      courses.add(TeacherCourse(
          courseName: json["recent_courses"][i]["subject"],
          courseDate: json["recent_courses"][i]["start_date"]));
    }
    return TeacherModel(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        birthDate: json["birth_date"],
        credentials: json["credentials"],
        teacherCourse: courses);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone_number": phoneNumber,
      "birth_date": birthDate,
      "credentials": credentials,
    };
  }
}
