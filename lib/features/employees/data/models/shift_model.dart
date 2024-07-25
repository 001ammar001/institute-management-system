import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';

class ShiftModel extends ShiftEntity {
  const ShiftModel({
    super.id,
    required super.name,
    required super.startTime,
    required super.endTime,
    required super.days,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    List<int> days =
        json["working_days"].map((e) => int.parse(e)).toList().cast<int>();
    days.sort();

    return ShiftModel(
      id: json["id"],
      name: json["name"],
      startTime: json["starting_hour"],
      endTime: json["ending_hour"],
      days: days.toSet(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "start": startTime,
      "end": endTime,
      "days": days.join(","),
    };
  }
}
