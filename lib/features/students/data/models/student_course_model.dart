class StudentCourseModel {
  final int id;
  final String subject;
  final String startdate;

  StudentCourseModel({
    required this.id,
    required this.subject,
    required this.startdate,
  });

  factory StudentCourseModel.fromJson(Map<String, dynamic> json) {
    return StudentCourseModel(
        id: json['id'],
        subject: json['subject'],
        startdate: json['start_date']);
  }
}

class StudentCourseModelList {
  final List<StudentCourseModel> data;
  StudentCourseModelList({required this.data});

  factory StudentCourseModelList.fromJson(Map<String, dynamic> json) {
    return StudentCourseModelList(
      data: json['data']
          .map<StudentCourseModel>((x) => StudentCourseModel.fromJson(x))
          .toList(),
    );
  }
}
