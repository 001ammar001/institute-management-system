import '../../../../core/constants.dart';

class UserModelList {
  List<User>? data;
  Links? links;
  Meta? meta;

  UserModelList({this.data, this.links, this.meta});

  UserModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class User {
  int? id;
  String? username;
  Role? role;
  Role? employee;
  bool index = false;

  User({this.id, this.username, this.role, this.employee});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    employee =
        json['employee'] != null ? Role.fromJson(json['employee']) : null;
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
