import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {super.id,
      required super.username,
      required super.password,
      required super.role,
      super.employee});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "role_id": role.id,
      "employee_id": employee?.id != 0 ? employee?.id : null
    };
  }
}

class UserDetailsModel extends UserDetailsEntity {
  UserDetailsModel(
      {super.id,
      required super.username,
      required super.role,
      super.employee,
      required super.userActivityInfo});
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> activitiesMap = json["activities"];
    List<UserActivityInfo> userActivities = [];
    for (int i = 0; i < activitiesMap.length; i++) {
      userActivities.add(UserActivityInfo(
          activity: activitiesMap[i]["desc"].toString(),
          date: activitiesMap[i]["created_at"].toString()));
    }
    return UserDetailsModel(
        id: json['id'],
        username: json["username"],
        role: SearchEntity.fromJson(json["role"]),
        employee: (json["employee"] != null)
            ? SearchEntity.fromJson(json["employee"])
            : null,
        userActivityInfo: userActivities);
  }
}
