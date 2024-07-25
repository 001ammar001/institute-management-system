import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';

class RoomOrCategoryModel extends RoomOrCategoryEntity {

  bool? index=false;
  RoomOrCategoryModel({super.id, required super.name});

  factory RoomOrCategoryModel.fromJson(Map<String, dynamic> json) {
    return RoomOrCategoryModel(
      id: json["id"],
      name: json["name"] ?? json["category"],
    );
  }

  Map<String, dynamic> toRoomJson() {
    return {"id": id, "name": name};
  }

  Map<String, dynamic> toCategoryJson() {
    return {"id": id, "category": name};
  }
}
