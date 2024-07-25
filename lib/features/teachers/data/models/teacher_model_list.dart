import '../../../../core/constants.dart';

class TeacherModelList {
  List<Teachers>? data;
  Links? links;
  Meta? meta;

  TeacherModelList({this.data, this.links, this.meta});

  TeacherModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Teachers>[];
      json['data'].forEach((v) {
        data!.add(Teachers.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }


}

class Teachers {
  int? id;
  String? name;
  String? credentials;
  String? birthDate;
  String? phoneNumber;
  String? createdAt;
  List<RecentCourses>? recentCourses;
  bool index = false;

  Teachers(
      {this.id,
      this.name,
      this.credentials,
      this.birthDate,
      this.phoneNumber,
      this.createdAt,
      this.recentCourses});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    credentials = json['credentials'];
    birthDate = json['birth_date'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
    if (json['recent_courses'] != null) {
      recentCourses = <RecentCourses>[];
      json['recent_courses'].forEach((v) {
        recentCourses!.add(RecentCourses.fromJson(v));
      });
    }
  }

}

class RecentCourses {
  int? id;
  String? subject;
  String? startDate;

  RecentCourses({this.id, this.subject, this.startDate});

  RecentCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    startDate = json['start_date'];
  }

}
