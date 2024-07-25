class TeacherEntity {
  final int? id;
  final String name;
  final String phoneNumber;
  final String birthDate;
  final String credentials;
  final List<TeacherCourse>? teacherCourse;
  TeacherEntity(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.birthDate,
      required this.credentials,
      this.teacherCourse});
}

class TeacherCourse {
  final String courseName;
  final String courseDate;

  TeacherCourse({required this.courseName, required this.courseDate});
}
