import '../../../../core/constants.dart';

class ActivityModelList {
  List<Activities>? data;
  Links? links;
  Meta? meta;

  ActivityModelList({this.data, this.links, this.meta});

  ActivityModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Activities>[];
      json['data'].forEach((v) {
        data!.add(Activities.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class Activities {
  String? desc;
  String? createdAt;
  bool index = false;

  Activities({this.desc, this.createdAt});

  Activities.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    createdAt = json['created_at'];
  }
}
