import 'package:institute_management_system/features/courses/data/models/room_category_model.dart';

import '../../../../core/constants.dart';

class RoomCategoryModelList {
  List<RoomOrCategoryModel>? data;
  Links? links;
  Meta? meta;

  RoomCategoryModelList({this.data, this.links, this.meta});

  RoomCategoryModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RoomOrCategoryModel>[];
      json['data'].forEach((v) {
        data!.add(RoomOrCategoryModel.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}