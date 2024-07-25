import '../../../../core/constants.dart';

class StudentModelList {
  List<Students>? data;
  Links? links;
  Meta? meta;

  StudentModelList({this.data, this.links, this.meta});

  StudentModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Students>[];
      json['data'].forEach((v) {
        data!.add(Students.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

}

class Students {
  int? id;
  String? name;
  String? fatherName;
  String? birthDate;
  String? phoneNumber;
  String? createdAt;
  bool index = false;

  Students(
      {this.id,
      this.name,
      this.birthDate,
      this.phoneNumber,
      this.createdAt,
      this.fatherName});

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['father_name'];
    birthDate = json['birth_date'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
  }

}





