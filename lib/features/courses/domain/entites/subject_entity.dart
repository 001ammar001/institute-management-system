import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';

class SubjectEntity {
  final int? id;
  final RoomOrCategoryEntity category;
  final String subject;

  SubjectEntity({this.id, required this.subject, required this.category});
}
