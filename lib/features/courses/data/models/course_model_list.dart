import '../../../../core/constants.dart';

class CourseModelList {
  List<Courses>? data;
  Links? links;
  Meta? meta;

  CourseModelList({this.data, this.links, this.meta});

  CourseModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Courses>[];
      json['data'].forEach((v) {
        data!.add(Courses.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Courses {
  int? id;
  Subject? subject;
  Subject? room;
  Subject? teacher;
  int? minimumStudents;
  String? status;
  int? cost;
  Schedule? schedule;
  String? salaryType;
  int? salaryAmount;
  String? startAt;
  String? endAt;
  bool index = false;

  Courses(
      {this.id,
      this.subject,
      this.room,
      this.teacher,
      this.minimumStudents,
      this.status,
      this.cost,
      this.schedule,
      this.salaryType,
      this.salaryAmount,
      this.startAt,
      this.endAt});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    room = json['room'] != null ? Subject.fromJson(json['room']) : null;
    teacher =
        json['teacher'] != null ? Subject.fromJson(json['teacher']) : null;
    minimumStudents = json['minimum_students'];
    status = json['status'];
    cost = json['cost'];
    schedule =
        json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null;
    salaryType = json['salary_type'];
    salaryAmount = json['salary_amount'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }
}

class Subject {
  int? id;
  String? name;

  Subject({this.id, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Schedule {
  int? id;
  String? starts;
  String? ends;
  List<String>? days;

  Schedule({this.id, this.starts, this.ends, this.days});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    starts = json['starts'];
    ends = json['ends'];
    days = json['days'].cast<String>();
  }
}
