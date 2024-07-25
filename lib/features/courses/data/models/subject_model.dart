import 'package:institute_management_system/features/courses/data/models/room_category_model.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  SubjectModel({super.id, required super.subject, required super.category});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json["id"],
      category: RoomOrCategoryModel.fromJson(json["category"]),
      subject: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "subject": subject, "category_id": category.id};
  }
}
